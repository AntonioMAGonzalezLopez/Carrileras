// vuelco.m
// ========
// Apuntes de Antonio Gonzalez Lopez
// =================================

function [Mcr,sigi,sigr,s] = vuelco(s,sf,st,sc,tau,e1,h1,Iz,Iy,L,Wx);

mode(0);
clc
load("geom.dat", "Iz", "Iy", "L", "Wz");
load("datos.dat", "s", "sf", "st", "sc", "tau", "e1", "h1");

// sigf=input('Limite de fluencia (kg/cm2): ');
// Iy=input('Iy (cm4): ');
// Iz=input('Iz (cm4): ');
// Wz=input('Wz (cm3): ');
// L=input('luz (cm): ');
clc

sigf=sf;
It=Iy+Iz;
Mcr=3.1416*sqrt(2.1*8.44e11*Iy*It)/L;
sigi=Mcr/Wz;

if sigi>sigf*0.8
	cons=1.6*sigf-0.04*sigf^2/sigi;
        sigr=(cons+sqrt(cons^2-2.4*sigf^2))/2;
else
        sigr=sigi;
end
disp('Momento critico Timoshenko:  Mcr');
disp('tension critica ideal:       sigi');
disp('tension critica real:        sigr');
disp('tension de trabajo:          str');
disp('');
disp('     Mcr         sigi        sigr          str');
resul=[Mcr sigi sigr s];
disp(resul);
disp('');
disp('Si str < sigr entonces es valido, y no debe volcar.');
bb=input('Para continuar pulse enter. ');

disp('Fin de vuelco.sce');
bb=input('Para continuar pulse enter');

endfunction
