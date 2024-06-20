function Chlamy_Tracking(LOADname,analyze_range,THRESHOLD_IDENTIFY,THRESHOLD_TRACKING,MINIMUM_FRAME,SAVEname)
% analyze_range=[x_min, x_max; y_min, y_max; time_min, time_max]
% ex. [1200,1400;480,560; 1420,1430];

%% load file and colormap
load(LOADname);
%point_cell(2,***cells,***frames)
%diff_ALL
%diff_MEAN
orig_c=colormap(jet);
% close all
FIGname_allpoint=[LOADname,'_allpoint.fig'];
A=exist(FIGname_allpoint);
if(A==2)
    open(FIGname_allpoint);
    hold on
    rectangle('Position',[analyze_range(1,1),analyze_range(2,1),diff(analyze_range(1,:)),diff(analyze_range(2,:))],'EdgeColor','r')
end


%% define the x-y and time range for the analysis
THRESHOLD_IDENTIFY=THRESHOLD_IDENTIFY^2;

temp_cell=struct('point',[]);
count_cell=zeros(1,analyze_range(3,2)-analyze_range(3,1)+1);
for t=analyze_range(3,1):analyze_range(3,2)
    temp=point_cell(:,~isnan(point_cell(1,:,t)),t);
    flag=ones(1,size(temp,2));
    for ax=1:2% inside x-y range
        flag(1,temp(ax,:)<analyze_range(ax,1))=0;
        flag(1,temp(ax,:)>analyze_range(ax,2))=0;
    end
    temp2=repmat(temp(:,find(flag==1)),1,1,sum(flag));%xy coordinate
    temp2=(temp2-permute(temp2,[1,3,2]));% diff between chlamy
    temp2=temp2.*temp2;% squared
    temp3=tril(ones(size(temp2,2),size(temp2,2))*THRESHOLD_IDENTIFY);
    temp3=permute(cat(3,temp3,temp3),[3,1,2]);
    temp2=temp2+temp3;
    index_overlap=find(squeeze(sum(temp2,1))<THRESHOLD_IDENTIFY);
    if(size(index_overlap,2)>0)
        index_checked=find(flag==1);
        for ind_o=index_overlap.'
            [row,col] = ind2sub(size(squeeze(sum(temp2,1))),ind_o);
            if(temp(:,index_checked(1,row))>0&temp(:,index_checked(1,col))>0)
                % update x-y coordinate for 'row' chlamy
                temp(:,index_checked(1,row))=mean(temp(:,index_checked(1,[row,col])),2);
                % eliminate 'col' chlamy
                flag(1,index_checked(1,col))=0;
            end
        end
    end
    temp_cell(t-analyze_range(3,1)+1).point=temp(:,find(flag==1));
    count_cell(1,t-analyze_range(3,1)+1)=size(temp_cell(t-analyze_range(3,1)+1).point,2);
end

point_cell_range=nan(2,max(count_cell),analyze_range(3,2)-analyze_range(3,1)+1);
for t=1:size(temp_cell,2)
    point_cell_range(:,1:count_cell(1,t),t)=temp_cell(t).point;
end
clear temp temp2 temp3

%% plot the point
edit_c=resample(orig_c,size(point_cell_range,3),256);
edit_c(edit_c<0)=0;edit_c(edit_c>1)=1;
h3=figure;
hold on
for t=1:size(point_cell_range,3)
    scatter(point_cell_range(1,~isnan(point_cell_range(1,:,t)),t),point_cell_range(2,~isnan(point_cell_range(1,:,t)),t),'o','MarkerFaceColor',edit_c(t,:),'MarkerEdgeColor',edit_c(t,:));
    for i=1:sum(~isnan(point_cell_range(1,:,t)))
        text(point_cell_range(1,i,t)+0.4,point_cell_range(2,i,t)+0.4,num2str(t))
    end
end

%% make tracking
all_neighb=struct('indx',[],'xy',[]);
THRESHOLD_TRACKING=THRESHOLD_TRACKING^2;% maximum distance in pixel
for t=2:size(point_cell_range,3)%time
    temp=point_cell_range(:,:,t-1:t);
    ax_square=[];
    for ax=1:2
        temp2=shiftdim(temp(ax,:,:),1);
        temp3=repmat(temp2,1,1,size(temp2,1));
        temp4=squeeze(temp3(:,1,:))-squeeze(temp3(:,2,:)).';
        ax_square=cat(3,ax_square,temp4.*temp4);
    end
    ax_square=sum(ax_square,3);%x^2+y^2 for every pair
    
    %%
    temp_ax_square=ax_square;
    indx_neighb=[];
    for chlamy=find(temp_ax_square(:,1)>0).'% numbers for 'before'
        [Y,I]=min(temp_ax_square(chlamy,:),[],'omitnan');
        if Y<THRESHOLD_TRACKING
            indx_neighb=cat(2,indx_neighb,[chlamy;I(1,1)]);% make a pair
            temp_ax_square(:,I(1,1))=nan;% eliminate 'after' data
        end
    end
    %%
    all_neighb(1,t).indx=indx_neighb;
    if size(indx_neighb,1)>0
        all_neighb(1,t).xy=cat(3,temp(:,indx_neighb(1,:),1),temp(:,indx_neighb(2,:),2));
    end
end
clear temp temp2 temp3 temp4


%% check the instantaneous tracking
figure(h3);
edit_c=resample(orig_c,size(point_cell_range,3),256);
edit_c(edit_c<0)=0;edit_c(edit_c>1)=1;
for t=2:size(all_neighb,2)
    temp=all_neighb(1,t).xy;%xy, chlamy, b/a
    temp=cat(3,temp,nan(2,size(temp,2),1));
    temp=permute(temp,[1,3,2]);%xy,b/a/nan, chlamy
    temp=reshape(temp,2,[]);
    plot(temp(1,:),temp(2,:),'-','Color',edit_c(t,:))
end


%% unite tracking from the index in all_neighb
chlamy_ext=struct('time',[],'xy',[]);
chlamy_temp=struct('time',[],'xy',[]);
chlamy_temp_FlagLatestIndx=[0;0];
num_chlamy=0;

for t=2:size(all_neighb,2)-1
    indx_pre=all_neighb(1,t).indx;
    indx_post=all_neighb(1,t+1).indx;
    if(t==12)
        t=12;
    end
    if size(indx_pre,1)*size(indx_post,1)>0
        %% existing chlamy
        temp=find(chlamy_temp_FlagLatestIndx(1,:)==1);%working indx
        if(size(temp,2)>0)
            for chlamy=temp
                temp2=find(indx_post(1,:)==chlamy_temp_FlagLatestIndx(2,chlamy));
                if(size(temp2,2)>0)%following chlamy is found
                    chlamy_temp_FlagLatestIndx(2,chlamy)=indx_post(2,temp2);% renew latest indx
                    chlamy_temp(1,chlamy).time=cat(2,chlamy_temp(1,chlamy).time,t+1);%add time
                    chlamy_temp(1,chlamy).xy=cat(2,chlamy_temp(1,chlamy).xy,all_neighb(1,t+1).xy(:,temp2,2));%add time
                    indx_post(:,temp2)=0;
                else% there are no following chlamy
                    chlamy_temp_FlagLatestIndx(:,chlamy)=[2;0];%end of time-tracking
                end
            end
        end
        %% new time-trackable chlamy
        for chlamy=1:size(indx_pre,2)
            temp=find(indx_post(1,:)==indx_pre(2,chlamy));
            if(size(temp,2)>0)%a following chlamy is found
                if num_chlamy==0
                    num_chlamy=1;
                else
                    num_chlamy=size(chlamy_temp,2)+1;
                end
                chlamy_temp_FlagLatestIndx(1,num_chlamy)=1;%working chlamy
                chlamy_temp_FlagLatestIndx(2,num_chlamy)=indx_post(2,temp);
                chlamy_temp(1,num_chlamy).time=[t-1,t,t+1];
                chlamy_temp(1,num_chlamy).xy=cat(2,squeeze(all_neighb(1,t).xy(:,chlamy,:)),squeeze(all_neighb(1,t+1).xy(:,temp,2)));%xr pre-post
            end
        end
    else
        chlamy_temp_FlagLatestIndx=[0;0];
    end
end

clear temp temp2

%%
num_chlamy=0;
for chlamy=1:size(chlamy_temp,2)
    if(length(chlamy_temp(1,chlamy).time)>=MINIMUM_FRAME)
        num_chlamy=num_chlamy+1;
        chlamy_ext(1,num_chlamy).time=chlamy_temp(1,chlamy).time;
        chlamy_ext(1,num_chlamy).xy=chlamy_temp(1,chlamy).xy;
    end
end

h4=figure;
hold on
edit_c2=resample(orig_c,size(chlamy_ext,2),256);
edit_c2(edit_c2<0)=0;edit_c2(edit_c2>1)=1;
for chlamy=1:size(chlamy_ext,2)
    if(num_chlamy<10)
        plot(chlamy_ext(1,chlamy).xy(1,:),chlamy_ext(1,chlamy).xy(2,:),'o-','Color',edit_c2(chlamy,:),'MarkerFaceColor',edit_c2(chlamy,:),'MarkerEdgeColor',edit_c2(chlamy,:));
    else
        plot(chlamy_ext(1,chlamy).xy(1,:),chlamy_ext(1,chlamy).xy(2,:),'-','Color',edit_c2(chlamy,:),'MarkerFaceColor',edit_c2(chlamy,:),'MarkerEdgeColor',edit_c2(chlamy,:));
        plot(chlamy_ext(1,chlamy).xy(1,end),chlamy_ext(1,chlamy).xy(2,end),'o','Color',edit_c2(chlamy,:),'MarkerFaceColor',edit_c2(chlamy,:),'MarkerEdgeColor',edit_c2(chlamy,:));
    end
    text(chlamy_ext(1,chlamy).xy(1,1)+0.4,chlamy_ext(1,chlamy).xy(2,1)+0.4,num2str(chlamy_ext(1,chlamy).time(1,1)));
    text(chlamy_ext(1,chlamy).xy(1,end)+0.4,chlamy_ext(1,chlamy).xy(2,end)+0.4,num2str(chlamy_ext(1,chlamy).time(1,end)));
end
disp(num_chlamy)
%% save figure and mat
%A=input("Do you want to save the variable 'chlamy_ext'? 1=Yes, 0=No:");
%if(A==1)
THRESHOLD_IDENTIFY=sqrt(THRESHOLD_IDENTIFY);
THRESHOLD_TRACKING=sqrt(THRESHOLD_TRACKING);
% SAVEname=input("Please input FILEname to save (ex. chlamy001):","s");
save(SAVEname,'chlamy_ext','analyze_range','THRESHOLD_IDENTIFY','THRESHOLD_TRACKING','MINIMUM_FRAME');

%    A=input("Do you want to save the figures (same name with the file)? 1=Yes, 0=No:");
%    if(A==1)
Figname=[SAVEname,'_track1.png'];
saveas(h3,Figname,'png')
Figname=[SAVEname,'_track2.png'];
saveas(h4,Figname,'png')
%    end
%end




