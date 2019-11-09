clear all
clc
syms s po k0 k1 k2 k3 kess
A = [0 1;0 -po];
B = [0; k0];
C = [1/70 0];
Kp = [k1 k2];

pole_placement = s*eye(2,2) - A + B*Kp;
clearvars k0 po k3 %k1 k2
k0 = 3400;
po = 27;

detPP = det(pole_placement);
rPP = roots([1 po+k0*k2 k0*k1])

