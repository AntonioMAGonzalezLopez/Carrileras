// dimt.sce
// Apuntes de Antonio Gonzalez Lopez
// =================================

function [s,sf,st,sc,tau,e1,h1,Iz,Iy,Wz] = dimt(In,Mf,V,L);
    
// Determina vigas carrileras en doble te 
// con refuerzos de faldones en el ala superior
    
mode(0);
clc

load("esfu.dat", "In", "Mf", "V", "L");
// In=input('Momento de inercia vertical necesario (cm4): ');
// Mf=input('Momento flector maximo ponderado (cmKp): ');
// V=input('Fuerza cortsnte maxima (Kp):  ');
res=[In Mf V];
disp('Iznecesario  Mfmaxpond  Cortante Vmax');
disp(res);
sf=input('Limite de fluencia (kp/cm2):  ');
clc

while 4

while 5

h1=input('altura del alma (cm): ');
disp('Espesor del alma >= 0.8 cm');
e1=input('espesor del alma (cm): ');
b1=input('ancho del ala superior (cm): ');
b2=input('ancho del ala inferior (cm): ');
e2=input('espesor de las alas (cm) >= b1/20: ');
c=input('altura de los faldones (cm): ');
e3=input('espesor de los faldones (cm) >= c/10: ');
clc
h=h1+2*e2;
A1=e1*h1;
A2=b1*e2;
A3=b2*e2;
A4=2*c*e3;
A=A1+A2+A3+A4;
Iz1=e1*h1^3/12;
Iz2=b1*e2^3/12;
Iz3=b2*e2^3/12;
Iz4=2*e3*c^3/12;
yg=(A1*h/2+A2*(h-e2/2)+A3*e2/2+A4*(h-1-c/2))/A
Iz=Iz1+A1*(yg-h/2)^2+Iz2+A2*(h-e2/2-yg)^2+Iz3+A3*(yg-e2/2)^2;
Iz=Iz+Iz4+A4*(h-(c/2+1+yg))^2;
Wz=Iz/yg;
Iy=(e2*b1^3+c*((b1+2*e3)^3-b1^3))/12;
Wy=2*Iy/(b1+2*e3);
datos=[h1 b1 b2 c e1 e2 e3];
resp=[Iz Wz Iy Wy A yg];
disp('     Iz          Wz          Iy          Wy         A       yg');
disp('     cm4         cm3         cm4         cm3       cm2      cm');
disp(resp);
disp('');
disp('   h1    b1    b2     c    e1   e2   e3   (cm)');
disp(datos);
bb=input('Para continuar pulse enter. ');
sv=Mf/Wz;
sh=Mf/(10*Wy);

peso=A*L*10*7.85/10000;
spe=peso*L/(8*Wz);
sv=sv+spe;

s=sv+sh;
disp('tension maxima Kp/cm2');
disp(s);
bb=input('Para continuar pulse enter. ');
clc
disp('Peso de la viga: ');
disp(peso);
bb=input('Para continuar pulse enter. ');

if Iz>In
    if Iy>(In/10)
        if s<(sf*0.945)
            break
        end
    end
end
disp('Repite nuevos datos. El perfil dado no es valido');
bb=input('Para continuar pulse enter. ');

end // while 5

// Cortadura en la soldadura entre ala superior y alma
// ===================================================

clc
st=sv;
sc=Mf*(h1+2*e2-yg)/Iz; // en valor absoluto
tau=V/(h1*e1);

Me=2*c*e3*(h1+2*e2-1-c/2-yg)+b1*e2*(h1+3*e2/2-yg);
ts=V*Me/(0.8*e1*Iz);
disp('Tension de cortadura en la soldadura alma-ala superior');
disp('En la direccion zz');
disp(ts);
disp('Comprobar si es menor de 800 Kp/cm2');
disp('Aunque esta no es la maxima. Lo es en la direccion zz');
disp('La tension maxima principal de cortadura es sqrt(s^2/2+t^2)');
bb=input('Para continuar pulse enter. ');
clc
ssc=Mf*(h1+e2-yg)/Iz;
ss=ssc/2+sqrt((ssc/2)^2+ts^2);
tss=sqrt((ssc/2)^2+ts^2);
disp('Tension principal y maxima de compresion en la soldadura:');
disp(ss);
disp('Debe ser menor de 2200 Kp/cm2');
disp('Tension principal y maxima de cortadura en la soldadura:');
disp(tss);
disp('Debe ser menor de 800 Kp/cm2');
bb=input('Para continuar pulse enter. ');

if ss<2200
    if tss<800
            break
    end
end

disp('Si se cumple que sigma<2200 y tau< 800, es una solucion valida.');
disp('Caso contrario, habra que reconsiderar el espesor del alma');
bb=input('Para continuar pulse enter. ');

end // while 4

clc
disp('Solucion valida para la soldadura del ala superior.');
bb=input('Para continuar pulse enter. ');

// Comprobacion de la soldadura del ala inferior.
// ==============================================

tau=(V*b2*e2*(yg-e2/2))/(0.8*e1*Iz);
disp('Tension de cortadura en la soldadura del ala inferior: Kp/cm2');
disp(tau);
disp('Comprobar que sea inferior a 800 Kp/cm2');
bb=input('Para continuar pulse enter. ');

save("datos.dat", "s", "sf", "st", "sc", "tau", "e1", "h1", "V");
save("geom.dat", "Iz", "Iy", "L", "Wz");

disp('fin de dimt.sce');
bb=input('Para continuar pulse enter');

endfunction

