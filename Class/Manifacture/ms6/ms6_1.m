% Shear strain, Shear angle
clear; clc;
Density=0.0028; %Density g/mm^3
Rake=deg2rad(10); %Tool rake angle
Clearance=deg2rad(8); %Tool clearance angle
Speed=250; %Cutting speed m/min
Depth=0.2; %Depth of cut mm
Width=2.5; %Cutting width mm
Length=27.58; %Length of chip
Weight=0.068; %Weight of chip

Thick=Weight/Density/Length/Width; %Thickness of chip, mm
Ratio=Depth/Thick; %Cutting ratio, r_c

Phi=atan(Ratio*cos(Rake)/(1-Ratio*sin(Rake))); %Shear angle
rad2deg(Phi) %degree
Strain=cos(Rake)/sin(Phi)/cos(Phi-Rake) %Shear strain