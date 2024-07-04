% Cost control
clear; clc;
Vol=600000; %Removed volume, mm3
VB=0.3; %Tool life, mm
CR=0.8; %Corner radius, mm
Fr=0.3; %Feed per rotation, mm
D=1.0;  %Depth of cut, mm
N=0.3; %VT^n=C
C=500; %VT^n=C
Tau=1; %Tool change, min
T3=15; %Preparation, min 
K1=1500; %Cost per time, yen/min
K2=1000; %Tool cost, yen

Speed=[100 200 300 400 500]; %Cutting speed, m/min
Life=[213.7 21.2 5.5 2.1 1.0]; %Tool life, min

Speed_mm = Speed * 1000; %Cutting speed, mm/min

CT=(Vol / (D * Fr)) ./ Speed_mm; %Cutting time
CC=K1 * CT + (K1 * Tau + K2) * (CT ./ Life) + K1 * T3; %Cost

plot(Speed,CT, "ro-", Speed,CC/1000, "bo-"); hold on;
axis([0,600,0,60]);
xlabel('Cutting speed, m/min');
ylabel('Time, min & Cost, thousand yen');
