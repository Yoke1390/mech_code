% Ideal shear angle
clear; clc; close all;
Density=0.0028; %Density g/mm^3
Rake=deg2rad(10); %Rake angle
Clearance=deg2rad(8); %Clearance angle
Speed=250; %Cutting speed m/min
Depth=0.2; %Depth of cut mm
Width=2.5; %Cutting width mm
Length=27.58; %Chip length
Weight=0.068; %Chip weight

Thick=Weight/Density/Length/Width; %Chip thickness mm
Ratio=Depth/Thick; %Cutting ratio
Force=[411.9 128.2];

Phi=atan(Ratio*cos(Rake)/(1-Ratio*sin(Rake))); %Shear angle

F=Force(1)*sin(Rake)+Force(2)*cos(Rake); %Rake force
N=Force(1)*cos(Rake)-Force(2)*sin(Rake); %

MU=F/N; %Friction coef
Beta=atan(MU); %Friction angle

R=Force(1)/cos(Beta-Rake) %Cutting force N
PhiK=rad2deg(pi/4-Beta+Rake) %Krystof, Maximum shear stress
PhiM=rad2deg(pi/4-Beta/2+Rake/2) %Merchant, Minimum energy


