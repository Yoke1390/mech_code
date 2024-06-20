k = 1;
c = 1;
m = 1;
T = 1;
d = 1;

A = [0 1 0;
    -k/m -c/m T/m;
    0 0 -1/T]

B = [0; 0; d/T];

lambda = eig(A)

K = [1 1 1]

lambda2 = eig(A-B*K)