// vigacarril.sce
// ==============
// Apuntes de Antonio Gonzalez Lopez
// =================================

mode(0);
clc

disp('Vigas carrileras que soporten una o dos gruas-puente.');
disp('');
disp('Dependiendo del numero de ruedas que entren simultaneamente en la viga,');
disp('las opciones son las siguientes:  ');
disp('');
disp('vigas con dos ruedas:     pulsar 2');
disp('vigas con tres ruedas:    pulsar 3');
disp('vigas con cuatro ruedas:  pulsar 4');
dato=input('Elegir y pulsar enter:  ');
clc
d=1;

while 1

if dato==2
//    exec("c:\vigcarr\viga2.sce");
//    [L,d2,d3,d4,p1,p2,p3,p4] = viga2(d);

// viga2.sce
// =========

// viga carrilera con dos cargas: la derecha mayor o igual a la izquierda.

clear

disp('viga con dos cargas: la derecha mayor o igual a la izquierda.');
disp('');
L=input('Luz de la viga (cm): ');
p1=input('carga izquierda (Kp): ');
p2=input('carga derecha (Kp): ');
d2=input('separacion entre cargas (cm): ');
clc

p3=0;
p4=0;
d3=0;
d4=0;

save("carga.dat", "p1", "p2", "p3", "p4");
save("dista.dat", "L", "d2", "d3", "d4");

x0=p1*d2/(p1+p2);
xd=(L+x0)/2;
if xd<d2
    disp('xd<d2 Hay una rueda fuera de la viga por la izquierda');
    bb=input('Para abortar pulse enter y se termina el programa');
    break
end


d1=xd-d2;

d3=L-d1-d2;
Ra=(p1*(d3+d2)+p2*d3)/L;
m1=Ra*d1;
m2=Ra*(d1+d2)-p1*d2;
s1=m1*d1/2;
s2=(m2-m1)*d2/2;
s3=m2*d2;
s4=m2*d3/2;
n1=d1/3+d2+d3;
n2=d2/3+d3;
n3=d2/2+d3;
n4=2*d3/3;
Rad=(s1*n1+s2*n2+s3*n3+s4*n4)/L;
mfd=Rad*(d1+d2)-s1*(d1/3+d2)-s2*d2/3-s3*d2/2;
I=mfd*1000/(2.1e6*L);
V=p2+p1*(L-d2)/L;
Mpond=m2*1.5;
resp=[m2 Mpond I V];

disp('     mfmax    Mfmax*(cmKp)   Ixnec(cm4)  CortmaxV');
disp(resp);

da=[x0 xd m1 m2 d1 d2 d3];
disp('       x0         xd         mc          md          d1       d2    d3');
disp(da);

In=I;
Mf=Mpond;

save("esfu.dat", "In", "Mf", "V", "L");

pc=input('Para continuar pulse enter.  ');

else // if dato==2
    if dato==3
//         exec("c:\vigcarr\viga3.sce");
//         [L,d2,d3,d4,p1,p2,p3,p4] = viga3(d);
        
        // viga3.m
// viga carrilera con tres cargas: la derecha es mayor y cercana a la central.

// variables.
// ----------

// m1, m2, y m3 momentos flectores sin ponderar.
// mfcD y mfcE momentos flectores conjugados.
// mfc el maximo de mfcD o mfcE.
// mfmax el mayor de m2 o m3 ponderado por 1.5.
// I momento de inercia necesario para L/1000.

clear

clc
L=input('Luz de la viga (cm): ');
clc
disp('viga carrilera con tres cargas:');
disp('la carga derecha es mayor y cercana a la central');
disp('las cargas izquierda y central pueden ser iguales o no');

p1=input('carga izquierda (Kp): ');
p2=input('carga central (Kp): ');
p3=input('carga derecha (Kp): ');
d2=input('separacion entre cargas izquierda y central (cm): ');
d3=input('separacion entre cargas central y derecha (cm): ');
clc

p4=0;
d4=0;

save("carga.dat", "p1", "p2", "p3", "p4");
save("dista.dat", "L", "d2", "d3", "d4");

// momento maximo bajo la carga derecha
// ====================================

R=p1+p2+p3;
R1=p1+p2;

x0e=(p1*d2+(p1+p2)*d3)/(p1+p2+p3);
x1=(p1*d2+(p1+p2)*d3)/(p1+p2);

xe=(L+x0e)/2;
if xe<(d2+d3)
    disp('xe<d2+d3 Hay una rueda fuera de la viga por la izquierda');
    bb=input('Para abortar pulse enter y se termina el programa');
    break
end


me=R*((L+x0e)*(L+x0e))/(4*L)-R1*x1;

// momento maximo bajo la carga central
// ====================================

x0d=(p1*d2-p3*d3)/(p1+p2+p3);

xd=(L+x0d)/2;
if d3>(L-xd)
    disp('d3>L-xd Hay una rueda fuera de la viga por la derecha');
    bb=input('Para abortar pulse enter y se termina el programa');
    break
end


md=R*((L+x0d)*(L+x0d))/(4*L)-p1*d2;



if me>md
// momento en E mayor que el momento en D
// ======================================

    disp('ME>MD');
    bb=input('Para continuar pulse enter');


    d4=L-xe;
    d1=xe-(d2+d3);
    Ra=(p1*(d2+d3+d4)+p2*(d3+d4)+p3*d4)/L;
    m1=Ra*d1;
    m2=Ra*(d1+d2)-p1*d2;
    m3=Ra*(d1+d2+d3)-p1*(d2+d3)-p2*d3;

	s1=m1*d1/2;
	s2=m1*d2;
	s3=(m2-m1)*d2/2;
	s4=(m3-m2)*d3/2;
	s5=m2*d3;
	s6=m3*d4/2;

	n1=d1/3+d2+d3+d4;
	n2=d2/2+d3+d4;
	n3=d2/3+d3+d4;
	n4=d3/3+d4;
	n5=d3/2+d4;
	n6=2*d4/3;

    Rac=(s1*n1+s2*n2+s3*n3+s4*n4+s5*n5+s6*n6)/L;
    mfce=Rac*(d1+d2+d3)-s1*(d1/3+d2+d3)-s2*(d2/2+d3)-s3*(d2/3+d3)-s4*d3/3-s5*d3/2;
    
    I=mfce*1000/(2.1e6*L);
    Mfmax=me;
    disp('Mfmax en E');
    bb=input('Estaba previsto. Para continuar pulse enter');
 
else // if me>md
// momento en D mayor que el momento en E
// ====================================== 

    disp('MD>ME');
    bb=input('Para continuar pulse enter');
    
    d4=L-xd-d3;
    d1=xd-d2;
    Ra=(p1*(d2+d3+d4)+p2*(d3+d4)+p3*d4)/L;
    m1=Ra*d1;
    m2=Ra*(d1+d2)-p1*d2;
    m3=Ra*(d1+d2+d3)-p1*(d2+d3)-p2*d3;
    
    s1=m1*d1/2;
	s2=m1*d2;
	s3=(m2-m1)*d2/2;
	s4=(m2-m3)*d3/2;
	s5=m3*d3;
	s6=m3*d4/2;

	n1=d1/3+d2+d3+d4;
	n2=d2/2+d3+d4;
	n3=d2/3+d3+d4;
	n4=2*d3/3+d4;
	n5=d3/2+d4;
	n6=2*d4/3;
    
    Rac=(s1*n1+s2*n2+s3*n3+s4*n4+s5*n5+s6*n6)/L;   
    mfcd=Rac*(d1+d2)-s1*(d1/3+d2)-s2*d2/2-s3*d2/3;
    
    I=mfcd*1000/(2.1e6*L);
    Mfmax=md;
    
end // if me>md

Mpond=Mfmax*1.5;
V=p3+(p2*(L-d3)+p1*(L-d2-d3))/L;

resp=[Mfmax Mpond I V];
c=[xe xd d1 d2 d3 d4];
disp('   xe   xd   d1   d2   d3   d4')
disp(c);

disp('Mmax(cmKp)  Mponderado(cmKp)  Ixnec(cm4)   CortmaxV');
disp(resp);
disp('fin');
m=[m1 m2 m3];
disp('mc    md    me');
disp(m);

In=I;
Mf=Mpond;

save("esfu.dat", "In", "Mf", "V", "L");

        pc=input('Para continuar pulse enter.  ');
        
    else // if dato==3
//        exec("c:\vigcarr\viga4.sce");
//        [L,d2,d3,d4,p1,p2,p3,p4] = viga4(d);

// viga4.m
// ===============================================================

// viga carrilera con cuatro cargas: las dos izquierdas menores 
// que las dos de la derecha. Introducir cargas sin ponderar.

clear

clc
L=input('Luz de la viga (cm): ');
clc
disp('viga carrilera con cuatro cargas: las dos de la izquierdas menores');
disp('que las dos de la derecha.');
disp('');
disp('Introducir cargas sin ponderar: el programa las pondera por 1,5');
disp('');
p1=input('Carga izquierda primera (p1 en Kp): ');
p2=input('Carga segunda (p2 en Kp): ');
p3=input('Carga tercera (p3 en Kp): ');
p4=input('Carga cuarta  (p4 en Kp): ');
d2=input('separacion entre las dos cargas izquierdas(cm): ');
d4=input('separacion entre las dos cargas derechas(cm): ');
d3=input('separacion entre las cargas centrales (cm): ');
clc

save("carga.dat", "p1", "p2", "p3", "p4");
save("dista.dat", "L", "d2", "d3", "d4");

// Momento maximo en E
// ===================


R=p1+p2+p3+p4;
// situacion resultante respecto a P4: x0
// --------------------------------------
x0=(p1*d2+(p1+p2)*d3+(p1+p2+p3)*d4)/(p1+p2+p3+p4);

// distancia del centro de la viga a la carga mas proxima
// ======================================================

if x0<d4 then
    xe=(L+x0-d4)/2;
    if (L-xe)<d4
        disp('L-xe<d4 Hay una rueda fuera de la viga por la derecha');
        bb=input('Para abortar pulse enter y se termina el programa');
        break
    end
    if xe<d2+d3
        disp('xe<d2+d3 Hay una rueda fuera de la viga por la izquierda');
        bb=input('Para abortar pulse enter y se termina el programa');
        break
    end
    d5=L-d4-xe;
    disp('x0<d4');
    bb=input('Para continuar pulse enter');
else // if x0<d4
    if x0<(d3+d4)
        xe=(L+x0-d4)/2;
        if (L-xe)<d4
            disp('L-xe<d4 Hay una rueda fuera de la viga por la derecha');
            bb=input('Para abortar pulse enter y se termina el programa');
            break
        end
        if xe<d2+d3
            disp('xe<d2+d3 Hay una rueda fuera de la viga por la izquierda');
            bb=input('Para abortar pulse enter y se termina el programa');
            break
        end
        d5=L-d4-xe;
        disp('d4<x0<d3+d4');
        bb=input('Para continuar pulse enter');
    else // if x0<d3+d4


        disp('x0>d3+d4 opcion no contemplada: aborte pulsando enter');
        bb=input('y se termina el programa...');

        d5=0;
        break
    end  // if x0<d3+d4
end // if x0<d4

d1=L-(d2+d3+d4+d5);
Ra=(d2*p1+d3*(p1+p2)+d4*(p1+p2+p3)+d5*(p1+p2+p3+p4))/L;
m1=Ra*d1;
m2=Ra*(d1+d2)-p1*d2;
m3=Ra*(d1+d2+d3)-p1*(d2+d3)-p2*d3;
m4=Ra*(d1+d2+d3+d4)-p1*(d2+d3+d4)-p2*(d3+d4)-p3*d4;

s1=m1*d1/2;
s2=(m2-m1)*d2/2;
s3=m1*d2;

if m2>m3
	s4=(m2-m3)*d3/2;
	s5=m3*d3;
else
	s4=(m3-m2)*d3/2;
	s5=m2*d3;
end

s6=(m3-m4)*d4/2;
s7=m4*d4;
s8=m4*d5/2;
n1=d1/3+d2+d3+d4+d5;;
n2=d2/3+d3+d4+d5;
n3=d2/2+d3+d4+d5;

if m2>m3
	n4=2*d3/3+d4+d5;
else
	n4=d3/3+d4+d5;
end

n5=d3/2+d4+d5;
n6=2*d4/3+d5;
n7=d4/2+d5;
n8=2*d5/3;
Rac=(s1*n1+s2*n2+s3*n3+s4*n4+s5*n5+s6*n6+s7*n7+s8*n8)/L;

if m2>m3
	mfc=Rac*(d1+d2)-s1*(d1/3+d2)-s2*d2/3-s3*d2/2;
	Mpond=m2*1.5;
else
	mfc=Rac*(d1+d2+d3)-s1*(d1/3+d2+d3)-s2*(d2/3+d3)-s3*(d2/3+d3)-s4*d3/3-s5*d3/2;
	Mpond=m3*1.5;
end

I=mfc*1000/(2.1e6*L);
V=p4+(p3*(L-d4)+p2*(L-d3-d4)+p1*(L-d2-d3-d4))/L;
resp=[Mpond I V];

disp('Mfmax*enE(cmKp) In(cm4) Cortmax(Kp)');
disp(resp);

momen=[x0 m1 m2 m3 m4];
disp('      x0           Mc          Md         Me          Mf');
disp(momen);

a=[d1 d2 d3 d4 d5];
disp('       d1      d2    d3     d4      d5');
disp(a);

disp('Datos de considerar la rueda E como causante de los maximos');
bb=input('Para continuar pulse enter');


// Momento maximo en D
// ===================

xd=(L-d3-d4+x0)/2;
d1=xd-d2;
d5=L-xd-d3-d4;
Ra=R*(d5+x0)/L;
M1=Ra*d1;
M2=Ra*(d1+d2)-p1*d2;
M3=Ra*(d1+d2+d3)-p1*(d2+d3)-p2*d3;
M4=Ra*(d1+d2+d3+d4)-p1*(d2+d3+d4)-p2*(d2+d4)-p3*d4;
mome=[x0 M1 M2 M3 M4];

disp('Datos de considerar la rueda D como causante de los maximos');
disp('Comprobacion del momento en D maximo');
disp('      x0           Mc          Md         Me          Mf');
disp(mome);
b=[d1 d2 d3 d4 d5];
disp('       d1      d2    d3     d4      d5');
disp(b);
bb=input('Para continuar pulse enter');

In=I;
Mf=Mpond;

save("esfu.dat", "In", "Mf", "V", "L");

disp('Fin');
        pc=input('Para continuar pulse enter.  ');
    end // if dato==3
end // if dato==2
clc

// Grafico
// ====================================================

load("carga.dat", "p1", "p2", "p3", "p4");
load("dista.dat", "L", "d2", "d3", "d4");

R=p1+p2+p3+p4;
x0=(d2*p1+d3*(p1+p2)+d4*(p1+p2+p3))/R;
F=L-(d2+d3+d4);
for i=1:F
     x(i)=i;
     RA(i)=R*(L+x0-(x(i)+d2+d3+d4))/L;
     mc(i)=RA(i)*x(i);
     md(i)=RA(i)*(d2+x(i))-p1*d2;
     me(i)=RA(i)*(x(i)+d2+d3)-p1*(d2+d3)-p2*d3;
     mf(i)=RA(i)*(x(i)+d2+d3+d4)-p1*(d2+d3+d4)-p2*(d3+d4)-p3*d4;
end
M=[x mc md me mf];
clc
disp('Momentos maximos bajo cada rueda');
disp('Estos momentos hansido calculados desplazando las rueas cm a cm');
disp('Para comprobar tacitamente la validez de los calculos teoricos.');
disp('mc');
disp(max(mc));
disp('md');
disp(max(md));
disp('me');
disp(max(me));
disp('mf');
disp(max(mf));
bb=input('Para continuar pulse enter');
disp('Mc = azul');
disp('Md = verde');
disp('Me = rojo');
disp('Mf = celeste');
plot(x,[mc md me mf])
disp('Aparte un poco el grafico.');
disp('Solamente coincide el valor maximo de los maximos.');
disp('Los demas son valores maximos producidos a lo largo de la viga');
disp('por las demas ruedas; que ademas son menores al maximo de los maximos');
bb=input('Para continuar pulse enter');
clc
disp('Dependiendo de la luz y de las cargas, sera suficiente con una IPE');
disp('a la que se le añade un PNU encima, con las alas hacia abajo;');
disp('o por el contrario se necesita una viga armada prefabricada');
disp('compuesta de chapas haciendo una doble t con faldones de refuerzo');
disp('en el ala superior, que soporten la flexion en horizontal.');
disp('');
disp('');
disp('Para elegir IPE con PNU pulse 1');
disp('Para elegir viga armada pulse 2');
d=input('Elegir y pulsar enter:     ');

if d==1
    exec("c:\carrileras\dimiu.sce");
    [IPE,PNU] = dimiu(In,Mf,V,L);
else
    exec("c:\carrileras\dimt.sce");
    [s,sf,st,sc,tau,e1,h1,Iz,Iy,Wz] = dimt(In,Mf,V,L);
    exec("c:\carrileras\rigid.sce");
    [skr,tki] = rigid(s,sf,st,sc,tau,e1,h1,V,Iz,Iy,L,Wz);
    exec("c:\carrileras\vuelco.sce");
    [Mcr,sigi,sigr,s] = vuelco(s,sf,st,sc,tau,e1,h1,Iz,Iy,L,Wz);
    disp('Fin de vuelco en vigacarril');
    bb=input('Para continuar pulse enter. ');
end

break

end // fin del while 1

disp('Fin de vigacarril.sce');




