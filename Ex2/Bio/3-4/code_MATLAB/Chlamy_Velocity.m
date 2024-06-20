function Chlamy_Velocity(FILEname)%%FILEname='output_DemoLeftON_wide';
%% load file
% close all
load(FILEname)
Fs=30;
variables{1}.name='moving time';
variables{2}.name='x distance';
variables{3}.name='y distance';
variables{4}.name='x velocity';
variables{5}.name='y velocity';


%% x,y軸方向の速度を計算する
CalcVelocity=zeros(5,size(chlamy_ext,2));
for chlamy=1:size(chlamy_ext,2)
    CalcVelocity(1,chlamy)=length(chlamy_ext(1,chlamy).time)/Fs;%動いていた時間 (秒)
    CalcVelocity(2,chlamy)=diff(chlamy_ext(1,chlamy).xy(1,[1,end]));%x軸方向の総移動距離 (pixel)
    CalcVelocity(3,chlamy)=diff(chlamy_ext(1,chlamy).xy(2,[1,end]));%x軸方向の総移動距離 (pixel)
end
CalcVelocity(4,:)=CalcVelocity(2,:)./CalcVelocity(1,:);% pixel/second
CalcVelocity(5,:)=CalcVelocity(3,:)./CalcVelocity(1,:);

%% 度数分布を描画して、正規分布と比較する
% 描画するデータを選ぶ
h1=figure;
for disp_indx=4:5
    % disp_indx=4;  % x軸方向の速度
    % disp_indx=5;    % y軸方向の速度
    %
    % スタージェスの公式で最適な階級数を計算する
    num_hist=1+log2(size(CalcVelocity,2));
    % disp(['num_hist = ',num2str(num_hist)]);

    h2=figure;
    % 度数分布 (ヒストグラム) を表示する
    % 階級の値を自動で決める場合
    % h=histogram(CalcVelocity(disp_indx,:));
    % 階級数を指定する場合 (上で計算したnum_histを使う)
    h=histogram(CalcVelocity(disp_indx,:),round(num_hist));
    % 階級の境界を指定する場合
    % h=histogram(CalcVelocity(disp_indx,:),-500:10:500);
    xlabel([variables{disp_indx}.name, ' [pixel/second]'])

    % 度数分布と正規分布とを比較する
    % 正規性の検定
    [h_lillie,p_lillie]=lillietest(CalcVelocity(disp_indx,:),'Alpha',0.05);
    % 描画
    bar_y=h.Values/(length(CalcVelocity(disp_indx,:))*h.BinWidth);
    bar_x=mean(cat(1,h.BinEdges(1,1:end-1),h.BinEdges(1,2:end)));
    x_min=h.BinEdges(1,1);
    x_max=h.BinEdges(1,end);
    %close(h2);
    figure(h1)
    subplot(3,2,disp_indx-3)
    bar(bar_x,bar_y,1);
    mean_velocity=mean(CalcVelocity(disp_indx,:));
    std_velocity_uncorrected=std(CalcVelocity(disp_indx,:),1);% standarized by N
    std_velocity_corrected=std(CalcVelocity(disp_indx,:),0);% standarized by N-1
    %disp(['DATANUM = ', num2str(size(CalcVelocity,2)),',   MEAN = ',num2str(mean_velocity),',  STD = ',num2str(std_velocity_uncorrected),' (uncorrected),  ',num2str(std_velocity_corrected),' (corrected),  ']);
    set(gca,'xlim',[min(x_min,mean_velocity-3*std_velocity_uncorrected),max(x_max,mean_velocity+3*std_velocity_uncorrected)]);    
    hold on
    x=x_min:10:x_max;
    y = normpdf(x,mean_velocity,std_velocity_uncorrected);
    switch h_lillie
        case 1
            plot(x,y,'k-')
            plot([mean_velocity,mean_velocity],[0,max(y)*1.1],'k-')
        case 0
            plot(x,y,'r-')
            plot([mean_velocity,mean_velocity],[0,max(y)*1.1],'r-')
    end
    text(mean_velocity-std_velocity_uncorrected,max(y)*0.9,['mean=',num2str(mean_velocity)],'FontSize',7);
    xlabel(variables{disp_indx}.name);
    % title(['Histogram of ',variables{disp_indx}.name]);

    %% 信頼区間と有意水準の計算
    pd=fitdist(CalcVelocity(disp_indx,:).','Normal');
    [h_t,p_t]=ttest(CalcVelocity(disp_indx,:));

    %% 棒グラフの描画
    subplot(3,2,disp_indx-1)
    data_bar=repmat(mean_velocity,1,3);
    bar(data_bar)
    hold on
    errorbar(1:3,data_bar,repmat(std_velocity_uncorrected,1,3).*[1,2,3]);
    x_temp=rand(1,size(CalcVelocity,2))*0.1+0.3;
    scatter(x_temp,CalcVelocity(disp_indx,:),'k.');
    set(gca,'xlim',[0,4])
    xticklabels({'sigma','sigma*2','sigma*3'})
    xlabel('errorbar')
    ylabel('velocity, pixels/sec');
    
    temp_quantile=quantile(CalcVelocity(disp_indx,:),[0.025,0.16,0.84,0.975]);
    for i=1:4
        plot([0,4],[temp_quantile(1,i),temp_quantile(1,i)],'m--')
    end
    plot([0,4],[mean_velocity,mean_velocity],'r-')


    %% ボックスプロットの描画
    subplot(3,2,disp_indx+1)
    boxplot(CalcVelocity(disp_indx,:));
    hold on
    x_temp=rand(1,size(CalcVelocity,2))*0.1+0.3;
    scatter(x_temp,CalcVelocity(disp_indx,:),'k.');
    set(gca,'xlim',[0,2])
    xticklabels({variables{disp_indx}.name})
    ylabel('velocity, pixels/sec');
    
    [p_wilcoxon,h_wilcoxon]=signrank(CalcVelocity(disp_indx,:));

    %% 検定結果の出力
    disp(['--- RESULT ',variables{disp_indx}.name,' ---']);
    disp(['DATANUM = ', num2str(size(CalcVelocity,2)),',   MEAN = ',num2str(mean_velocity),',  STD = ',num2str(std_velocity_uncorrected),' (uncorrected),  ',num2str(std_velocity_corrected),' (corrected)  ']);
    disp(['lillie test: p = ',num2str(p_lillie)]);
    disp(['ttest: p = ',num2str(p_t)]);
    disp(['Wilcoxon: p = ',num2str(p_wilcoxon)]);

end
Figname=[FILEname,'_test.png'];
saveas(h1,Figname,'png')

return;
