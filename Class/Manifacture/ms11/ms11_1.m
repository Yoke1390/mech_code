% VT graph
clear; clc;
VB=0.3; %Tool life, mm
CR=0.8; %Corner radius, mm
Fr=0.3; %Feed per rotation, mm
D=1.0;  %Depth of cut, mm
Speed=[100 200 300 400 500]; %Cutting speed, m/min
Life=[213.7 21.2 5.5 2.1 1.0]; %Tool life, min
LSpeed=log10(Speed); %Cutting speed, m/min
LLife=log10(Life); %Tool life, min

%VT^n=C, logV=-nlogT+logC
loglog(Life,Speed,'o'); hold on; %Plot
p=polyfit(LLife,LSpeed,1); %Approximate equation
LSpeed2=polyval(p,LLife); %Approx line
loglog(Life,10.^LSpeed2); %Plot
N=p(1)
C=10^p(2)

axis([1 1000 1 1000]);
xlabel('Tool life, min');
ylabel('Cutting speed, m/min');

% 切削速度 [m/min] 工具寿命 [min] 切削時間  [min] 100 200 300 400 500 加工費用  [千円] 213.7 21.2 5.5 2.1 1.0 35.1 25.5 22.9 22.4 23.0 52.7 38.7 35.5 35.9 38.5
