// dimiu.sce
// Apuntes de Antonio Gonzalez Lopez
// =================================

// Determina vigas carrileras en IPE 
// con PNU en la platabanda superior
function [IPE,PNU] = dimiu(In,Mf,V,L);

mode(0);
clc
// El prontuario de PNU
// contiene por columna:
// Ivu, Ihu, au, hu, h1, e, c pru(7*13)
// load("prontu.dat", "pru");

// El prontuario de IPE
// contiene por columna:
// Ivi, ai, hi, b, e1 pri(5*18)
// load("pronti.dat", "pri");

// pront.sce
// =========
// Determina vigas carrileras en IPE 
// con PNU en la platabanda superior

mode(0);

// El prontuario de PNU
// contiene por columna:
// Ivu, Ihu, au, hu, h1, e, c pru(7*13)
pru=[19.4 106 11 8 4.6 0.6 1.45
29.3 206 13.5 10 6.4 0.6 1.55
43.2 364 17 12 8.2 0.7 1.6
62.7 605 20.4 14 9.8 0.7 1.75
85.3 925 24 16 11.5 0.75 1.84
114 1350 28 18 13.3 0.8 1.92
148 1910 32.2 20 15.1 0.85 2.01
197 2690 37.4 22 16.7 0.9 2.14
248 3600 42.3 24 18.4 0.95 2.23
317 4820 48.3 26 20 1 2.36
399 6280 53.3 28 21.6 1 2.53
495 8030 58.8 30 23.2 1 2.7
597 10870 75.8 32 24.6 1.4 2.6];
// save("prontu.dat", "pru");

// El prontuario de IPE
// contiene por columna:
// Ivi, ai, hi, b, e1 pri(5*18)
pri=[80.1 7.64 8 4.6 0.52
171 10.3 10 5.5 0.57
318 13.2 12 6.4 0.63
541 16.4 14 7.3 0.69
869 20.1 16 8.2 0.74
1320 23.9 18 9.1 0.8
1940 28.5 20 10 0.85
2770 33.4 22 11 0.92
3890 39.1 24 12 0.98
5790 45.9 27 13.5 1.02
8360 53.8 30 15 1.07
11770 62.6 33 16 1.15
16270 72.7 36 17 1.27
23130 84.5 40 18 1.35
33740 98.8 45 19 1.46
48200 116 50 20 1.6
67120 134 55 21 1.72
92080 156 60 22 1.9];
// save("pronti.dat", "pri");
clc

// In=input('Momento de inercia vertical necesario (cm4):  ');
// mfp=input('momento flector vertical ponderado (cm.kp):  ');
sf=input('Limite de fluencia:  ');
// sadm=input('sigma admisible ponderada: ');
clc
load("esfu.dat", "In", "Mf", "V", "L");
mfp=Mf;
sadm=sf;

i=1;
j=1;
while 2
    Ihu=pru(i,2);
    if Ihu>(In/10)
        disp('El perfil PNU minimo necesario es: PNU-');
        pnu=80+20*(i-1);
        disp(pnu);
        disp('Elija una IPE de pareja, igual o menor a la reflejada.');
        disp('IPE: 80 100 120 140 160 180 200 220 240 270 300 330 360');
        disp('PNU: 80 100 100 120 120 140 160 160 180 200 200 220 240');
        disp('');
        disp('IPE: 400 450 500 550 600 600');
        disp('PNU: 240 260 260 280 300 320');
        IPE=input('Pareja en IPE:  ');
        if IPE<270
            j=(IPE-80)/20+1;
        else
            if IPE<400
                j=(IPE-270)/30+10;
            else
                j=(IPE-400)/50+14;
            end
        end
        break
    end
    i=i+1;
    if i==14
        disp('No es posible la combinacion.');
        disp('El PNU-320 no es suficiente.');
        ee=input('Pulse enter para continuar');
        break
    end
end // fin while 2

// El prontuario de IPE
// contiene por columna:
// Ivi, ai, hi, b, e1 pri(5*18)
// recupera datos de la IPE
Ivi=pri(j,1);
ai=pri(j,2);
hi=pri(j,3);
b=pri(j,4);
e1=pri(j,5);
// El prontuario de PNU
// contiene por columna:
// Ivu, Ihu, au, hu, h1, e, c pru(7*13)
// recupera datos del PNU
Ivu=pru(i,1);
Ihu=pru(i,2);
au=pru(i,3);
hu=pru(i,4);
h1=pru(i,5);
e=pru(i,6);
c=pru(i,7);
    
yg=(ai*hi/2+au*(hi+e-c))/(ai+au);
ygu=hi+e-c-yg;
ygi=yg-hi/2;
Iv=Ivu+au*ygu^2+Ivi+ai*ygi^2;
Ih=Ihu+e1*b^3/12;
wv=Iv/yg;
wh=2*Ih/hu;
if Iv>In
    sv=mfp/wv;
    sh=mfp/(10*wh);
    s=sv+sh;
    if s<sadm
        clc
        disp('La solucion es:');
        if j<10
            IPE=80+20*(j-1);
        else
            if j<14
                IPE=270+30*(j-10);
            else
                IPE=400+50*(j-14);
            end
        end
        PNU=80+20*(i-1);
        disp('IPE - ');
        disp(IPE);
        disp('PNU - ');
        disp(PNU);
        disp('El momento de inercia Iv es: ');
        disp(Iv);
        disp('El momento de inercia Ih es: ');
        disp(Ih);
        disp('cm4');
        disp('La tension es: ');
        disp(s);
        disp('kp/cm2');
        ee=input('Pulse enter para continuar');
    else
        disp(s);
        disp('La tension s es mayor que la admisible')
        ee=input('Pulse enter para continuar');            
    end
else
    disp(Iv);
    disp('Iv es menor del necesario. Elija una IPE mayor');
    disp('Para continuar se aborta el programa');
    ee=input('Pulse enter para continuar');
end
clc
while 3
    disp('Elija una pareja de PNU e IPE: ');
    disp('IPE: 80 100 120 140 160 180 200 220 240 270 300 330 360');
    disp('PNU: 80 100 100 120 120 140 160 160 180 200 200 220 240');
    disp('');
    disp('IPE: 400 450 500 550 600 600');
    disp('PNU: 240 260 260 280 300 320');
    disp('Para cada IPE el PNU debe ser el correspondiente o mayor');
    disp('¿Que pareja de perfiles desea comprobar?');

    IPE=input('Perfil IPE - ');
    if IPE<270
        j=(IPE-80)/20+1;
    else
        if IPE<400
            j=(IPE-270)/30+10;
        else
            j=(IPE-400)/50+14;
        end
    end
    PNU=input('Perfil PNU - ');
    i=(PNU-80)/20+1;        
    clc
    
    Ivi=pri(j,1);
    ai=pri(j,2);
    hi=pri(j,3);
    b=pri(j,4);
    e1=pri(j,5);

    Ivu=pru(i,1);
    Ihu=pru(i,2);
    au=pru(i,3);
    hu=pru(i,4);
    h1=pru(i,5);
    e=pru(i,6);
    c=pru(i,7);
    
    yg=(ai*hi/2+au*(hi+e-c))/(ai+au);

    ygu=hi+e-c-yg;
    ygi=yg-hi/2;
    Iv=Ivu+au*ygu^2+Ivi+ai*ygi^2;
    Ih=Ihu+e1*b^3/12;
    wv=Iv/yg;
    wh=2*Ih/hu;
    
    sv=mfp/wv;
    sh=mfp/(10*wh);
    s=sv+sh;
    resultado=[sv sh s]

    disp('IPE - ');
    disp(IPE);
    disp('PNU - ');
    disp(PNU);
    disp('El momento de inercia necesario Izz es:');
    disp(In);
    disp('El momento de inercia Izz es: ');
    disp(Iv);
    disp('El momento de inercia Iyy es: ');
    disp(Ih);
    disp('cm4');
    ee=input('Pulse enter para continuar');
    disp('La tension sigma vertical  -  horizontal   - total s: ');
    disp(resultado);
    disp('kp/cm2');
    disp('Si la solucion es valida, pulse: 1 ');
    de=input('Caso contrario pulse: 0  ');
    if de==1
        clc
        break
    end
end //fin while 3

disp('Fin de dimiu.sce');
ee=input('Pulse enter para continuar');

endfunction



