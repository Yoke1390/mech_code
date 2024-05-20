format short e;
format compact;
clear all;
close all;

m1 = 1;
m2 = 1;

k1 = 30;
k2 = 20;

d1 = 0.1;
d2 = 0.001;

A = [0           0           1           0;
     0           0           0           1;
     -(k1+k2)/m1 k2/m1       -(d1+d2)/m1 d2/m1;
     k2/m2       -k2/m2      d2/m2       -d2/m2];

B = [0; 0; 0; 1/m2];
C1 = [1 0 0 0];
C2 = [0 1 0 0];
D = 0;

sys1 = ss(A, B, C1, D);
sys2 = ss(A, B, C2, D);

time = linspace(0, 20, 5000);
omega = logspace(-1, 2, 1000);

impulse(sys1, time)
title("fにインパルス信号を入力したときのx1の応答")
saveas(gcf, "assignment1.png")

impulse(sys2, time)
title("fにインパルス信号を入力したときのx2の応答")
saveas(gcf, "assignment2.png")

bode(sys1, omega)
title("fからx1への伝達関数のボード線図")
saveas(gcf, "assignment3.png")

bode(sys2, omega)
title("fからx2への伝達関数のボード線図")
saveas(gcf, "assignment4.png")
