clear all
clc
syms s kess

k0 = 3400;
po = 27;

k2 = 0.01
k1 = 850*k2^2 + 13.5*k2 + 729/13600
pa = -1700*k2-17/2
A = [0 1;0 -po];
B = [0; k0];
C = [1/70 0];
Kp = [k1 k2];

% pole_placement = s*eye(2,2) - A + B*Kp;

AcliPP = A - B*Kp;
ess = 1- kess*C*(inv(s*eye(2,2)-AcliPP))*B
latex(ess)

