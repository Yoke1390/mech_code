% VT graph
clear; clc;
VB=0.3; %Tool life, mm
CR=0.8; %Corner radius, mm
Fr=0.3; %Feed per rotation, mm
D=1.0;  %Depth of cut, mm
Speed=????; %Cutting speed, m/min
Life=????; %Tool life, min
LSpeed=log10(Speed); %Cutting speed, m/min
LLife=log10(Life); %Tool life, min

%VT^n=C, logV=-nlogT+logC
loglog(Life,Speed,'o'); hold on; %Plot
p=polyfit(LLife,LSpeed,1); %Approximate equation
LSpeed2=polyval(p,LLife); %Approx line
loglog(Life,10.^LSpeed2); %Plot
N=????
C=????

axis([1 1000 1 1000]);
xlabel('Tool life, min');
ylabel('Cutting speed, m/min');


