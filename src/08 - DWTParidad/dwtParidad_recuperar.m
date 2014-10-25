%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dwtParidad_recuperar.m                  |%
%|  Función:  extracción de la marca de agua por el método |%
%|            DWT basado en la paridad.                    |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load datosDWTParidad.mat;
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
% file_name = 'dwtParidad_watermarked.bmp';
file_name = 'dwtParidad_watermarkedMod.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'dwtParidad_JPEGatack.jpg';
% file_name = 'dwtParidad_NOISEatack.bmp';
% file_name = 'dwtParidad_MEANatack.bmp';
% file_name = 'dwtParidad_CROPPINGatack.bmp';
% file_name = 'dwtParidad_SCALEDatack.bmp';
% file_name = 'dwtParidad_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se crea la marca de agua que será un vector de 128 bits pseudoaleatorios
rand('state',key); 
orig_watermark = ceil(2*rand(tam*tam,1)-1);

[cA1,cH1,cV1,cD1] = dwt2(watermarked_image,'haar');
[cA2,cH2,cV2,cD2] = dwt2(cA1,'haar');

% se extrae la marca de agua
watermark = zeros(1,tam*tam);
k = 1;
for i = 1:tam
  for j = 1:tam
    coef = floor(cA2(i,j)/constante);
    if(mod(coef,2) == 1)
      watermark(k) = 1;
    end
    k = k+1;
  end
end

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errVector(orig_watermark,watermark,tam);

% se calcula la similaridad
graf = similaridad(orig_watermark,watermark,tam,tam);
title('Similaridad');

% se guarda la gráfica en un fichero
cd 'ImagenesPruebas'
I = getframe(gcf);
% imwrite(I.cdata,'dwtParidad_similaridad.bmp');
imwrite(I.cdata,'dwtParidad_similaridadMod.bmp');
cd ..
