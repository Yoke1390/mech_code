% Optimal cutting speed under control parameter V and F
clear; clc;
Vol=600000; %Removed volume, mm3
VB=0.3; %Tool life, mm
CR=0.8; %Corner radius, mm
D=1.0;  %Depth of cut, mm
Rz=0.01; %Surface roughness, mm
N=0.3; %VT^nF^m=C
M=0.5; %VT^nF^m=C
C=275; %VT^nF^m=C
Tau=1; %Tool change, min
T3=15; %Preparation, min 
K1=1500; %Cost per time, yen/min
K2=1000; %Tool cost, yen

Speed=[100 200 300 400 500]; %Cutting speed, m/min
Fr=[0.1 0.15 0.2 0.25 0.3]';
Life=[1352.4 134.2 34.7 13.3 6.3;
    688.1 68.3 17.7 6.8 3.2;
    426.0 42.3 10.9 4.2 2.0;
    293.7 29.1 7.5 2.9 1.4;
    216.7 21.5 5.6 2.1 1.0]; %Tool life, min

%CT=Vol./(D*Fr*1000.*Speed)+Tau*Vol./(D*Fr*1000.*Speed)./Life+T3; %Cutting time
CC=(K1.*Vol./(D.*Fr*1000.*Speed)+(K1*Tau+K2).*Vol./(D.*Fr*1000.*Speed)./Life+K1*T3)/1000 %Cost

Fmax=sqrt(8*Rz*CR); %Max of feed

Vtm=C/((1/N-1)*Tau)^N
Ttm=(1/N-1)*Tau
Vcm=C/((1/N-1)*(Tau+K2/K1))^N
Tcm=(1/N-1)*(Tau+K2/K1)