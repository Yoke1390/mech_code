function Chlamy_LoadData(Folder_name)
s=['cd ',Folder_name];
eval(s)
SAVEname=Folder_name;

Num_file=0;
Num_flame=1000;
Num_chlamy=10;
point_cell=nan(2,Num_chlamy,Num_flame);

while 1%Num_file<10
    Num_file=Num_file+1;
    FILEname=['file_',num2str(Num_file),'.txt']
    A=exist(FILEname);
    if(A~=2)
        break;
    else
        fileID=fopen(FILEname);
        if(Num_file>Num_flame)%フレーム数を更新
            Num_flame=Num_file;
            point_cell=cat(3,point_cell,nan(2,Num_chlamy));
        end
        data_cell=textscan(fileID,'%f,%f');%data_cell{1,2}cell
        data_mat=cell2mat(data_cell);
        data_elimnan=data_mat(~isnan(sum(data_mat,2)),:);%nanの行を削除
        if(Num_chlamy<size(data_elimnan,1))%現時点でのクラミドモナス数を超えたら更新する
            point_cell=cat(2,point_cell,nan(2,size(data_elimnan,1)-Num_chlamy,Num_flame));
            Num_chlamy=size(data_elimnan,1);
            disp(['New Num_chlamy = ',num2str(Num_chlamy)]);
        end
        point_cell(:,1:size(data_elimnan,1),Num_file)=data_elimnan.';
        fclose(fileID);
    end
end

cd ..
save(SAVEname,'point_cell');

%% draw all moving objects in all frame
h1=figure;
hold on
for t=1:size(point_cell,3)
scatter(squeeze(point_cell(1,:,t)).',squeeze(point_cell(2,:,t)).','k.');
end
FIGname=[SAVEname,'_allpoint.fig']
%%
saveas(gcf,FIGname)
FIGname=[SAVEname,'_allpoint.png']
saveas(gcf,FIGname,'png')