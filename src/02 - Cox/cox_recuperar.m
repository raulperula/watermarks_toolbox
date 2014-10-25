%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: cox_recuperar.m                         |%
%|  Función:  extracción de la marca de agua por el método |%
%|            Cox.                                         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load 'datosCox.mat'
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen original y se le cambia el tipo a double
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'cox_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'cox_JPEGatack.jpg';
% file_name = 'cox_NOISEatack.bmp';
% file_name = 'cox_MEANatack.bmp';
% file_name = 'cox_CROPPINGatack.bmp';
% file_name = 'cox_SCALEDatack.bmp';
% file_name = 'cox_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se reinicia el generador PN de MATLAB con "key", produce numeros
% aleatorios de N(0,1)
randn('state',key);

% se crea la marca de tamaño 'tam' inicializado todo a cero
orig_watermark = zeros(tam,1);
for i = 1:tam
  orig_watermark(i) = randn(1); 
end

% se calcula la DCT de la imagen original
dct = dct2(cover_object);

% se busca los coeficientes de mayor magnitud quitando el coeficiente DC,
% posicion (1,1)
A = dct(:);
B = A;
B(1) = 0;

% Y1 contiene el vector ordenado de forma descendiente, I1 contiene el
% valor de los índices
[Y1,I1] = sort(abs(B),'descend');

% se toma los coeficientes sin valor absoluto
Y1 = A(I1);

% se obtienen los índices correctos
V = Y1(1:tam);

% se calcula la DCT de la imagen marcada
dctmarcada = dct2(watermarked_image);
dctmarc = dctmarcada(:);
V1 = dctmarc(I1);
V1 = V1(1:tam);

% se extrae la marca
watermark = (V1-V)./(alpha*V);

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula la similaridad
graf = similaridad(orig_watermark,watermark,tam);
title('Similaridad');

% se guarda la gráfica en un fichero
cd 'ImagenesPruebas'
I = getframe(gcf);
imwrite(I.cdata,'cox_similaridad.bmp');
cd ..
