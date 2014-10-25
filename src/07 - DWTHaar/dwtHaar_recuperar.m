%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dwtHaar_recuperar.m                     |%
%|  Función:  extracción de la marca de agua por el método |%
%|            de la DWT con la transformada de Haar.       |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% carga de los datos necesarios para la extracción
cd 'Datos'
load datosDWTHaar.mat;
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'dwtHaar_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'dwtHaar_JPEGatack.jpg';
% file_name = 'dwtHaar_NOISEatack.bmp';
% file_name = 'dwtHaar_MEANatack.bmp';
% file_name = 'dwtHaar_CROPPINGatack.bmp';
% file_name = 'dwtHaar_SCALEDatack.bmp';
% file_name = 'dwtHaar_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se calcula la imagen de referencia a partir de la marcada
[LL H V D] = dwt2(watermarked_image,'haar');
ceros = zeros(Mw/2,Nw/2);
referenciamarcada = idwt2(LL,ceros,ceros,ceros,'haar');

% se reinicia el generador PN de MATLAB con "key"
rand('state',key);

% se crea la marca con 'tam' números aleatorios
orig_watermark = ceil(2*rand(tam,1)-1);

% se realiza la permutacion
permuta1 = randperm(contador);
permuta = permuta1(1:tam);

% se extrae la marca
watermark = zeros(tam,1);
for k = 1:tam
  l = permuta(k);
  vector = idx(l,:);
  i = vector(1);
  j = vector(2);
  if(watermarked_image(i,j) >= referenciamarcada(i,j))
    bit = 1; 
  else
    bit = 0;
  end
  watermark(k) = bit;     
end

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errVector(orig_watermark,watermark,tam);

% se calcula la similaridad
graf = similaridad(orig_watermark,watermark,tam);
title('Similaridad');

% se guarda la gráfica en un fichero
cd 'ImagenesPruebas'
I = getframe(gcf);
imwrite(I.cdata,'dwtHaar_similaridad.bmp');
cd ..
