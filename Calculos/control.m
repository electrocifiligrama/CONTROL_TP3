clear all
clc
syms s po k0 k1 k2 k3 kess
A = [0 1;0 -po];
B = [0; k0];
C = [1/70 0];
%K = [k1 k2 -k3];
Kp = [k1 k2];

%Aa = [A 0; -C 0];
%Ba = [B; 0];
%Bar = [0;0;1];
%Ca = [C 0];

%control_integral = s*eye(3,3) - Aa + Ba*K
%Acli = Aa - Ba*K
%det = det(control_integral)

pole_placement = s*eye(2,2) - A + B*Kp
%ess = 1 - C*(inv(s*eye(2*2)-AcliPP))*B
% zpk(det)
%ess = 1- Ca*(inv(s*eye(3,3)-Acli))*Bar
% (k0*k3)/70 + (po+k0*k2)*s^2 + s^3 + k0*k1*s
clearvars k0 po k3 %k1 k2
k0 = 3400;
po = 27;
%k1 = 0.1082;
%k2 = -11/3400;

detPP = det(pole_placement)
rPP = roots([1 po+k0*k2 k0*k1])
AcliPP = A - B*Kp
ess = 1- kess*C*(inv(s*eye(2,2)-AcliPP))*B;
vpa(ess)
%k3 = 1;
%r = roots([1 po+k0*k2 k0*k1 (k0*k3)/70]);
%vpa(r)
%psi = cos(atan(imag(r(2))/real(r(2))))
%wn = abs(r(2));
%tset = 4 / (psi*wn)
