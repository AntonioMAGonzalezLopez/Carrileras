// rigid
// =====
// Apuntes de Antonio Gonzalez Lopez
// =================================

// Determinacion de los rigidizadores de una viga carril

function [skr,tki] = rigid(s,sf,st,sc,tau,e1,h1,V,Iz,Iy,L,Wz);
  
mode(0);
clc

// Tensiones unitarias
// ===================
// sigmaf=input('limite de fluencia: ');
// disp('Dar los valores maximos en la viga,');
// disp('El programa estima los valores en el alma');
// disp('');
// sigmap=input('sigma maxima positiva: ');
// sigman=input('sigma maxima negativa (valor absoluto): ');
// tau=input('tension maxima de cortadura: ');
// clc
// Datos geometricos
// =================

load("datos.dat", "s", "sf", "st", "sc", "tau", "e1", "h1", "V");
load("geom.dat", "Iz", "Iy", "L", "Wz");
// t=input('Espesor del alma: ');
// h=input('altura del alma: ');
t=e1;
h=h1;
sp=0.8*sf;
sigmap=st;
sigman=sc;
sigmaf=sf;

while 6
    
a=input('separacion de rigidizadores (cm): ');
clc

// Tension maxima en valor absoluto
// ================================
if sigmap<sigman
        sigmam=sigman;
else
        sigmam=sigmap;
end
// Tension critica de Euler
// ========================
sc=1.898e6*(t/h)^2;
alfa=a/h;
// Tensiones criticas ideales
// ==========================
if alfa<2/3
        s1ki=(15.87+1.87/alfa^2+8.6*alfa^2)*sc;
else
        s1ki=23.9*sc;
end
if alfa>1
        tki=(5.34+4/alfa^2)*sc;
else
        tki=(4+5.34/alfa^2)*sc;
end
// Tensiones simultaneas normales y cortantes
// ==========================================
coe=-sigman/sigmap;
frac=sigmam/(4*s1ki);
num=sqrt(sigmam^2+3*tau^2);
den=(1+coe)*frac+sqrt(((3-coe)*frac)^2+(tau/tki)^2);
ski=num/den;
lsigmaf=0.8*sigmaf;
if ski>lsigmaf
	cons=1.6*sigmaf-0.04*sigmaf^2/ski;
        skr=(cons+sqrt(cons^2-2.4*sigmaf^2))/2;
else
        skr=ski;
end
// Resultados
// ==========
disp('ski=tension normal critica ideal');
disp('skr=tension normal critica real');
disp('tki=tension tangencial critica ideal');
disp(' s =tension normal de trabajo');
disp(' tau =tension tangencial de trabajo');

resp=[ski skr s tki tau];
disp('     ski         skr         s         tki         tau');
disp(resp);

if s<skr
    disp('La sigma critica real es menor que sigma de proporcionalidad');
    disp('y mayor que la sigma de trabajo:');
    disp('');
    disp('Por tanto valida');
    break
else
    disp('sigma critica menor que sigma de trabajo');
    disp('Disminuir separacion de rigidizadores.');
end

end // while 6
disp('Fin de rigid.sce');
bb=input('Para continuar pulse enter');

endfunction
