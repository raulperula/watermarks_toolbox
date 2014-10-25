%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svdIntercambio_recuperar.m              |%
%|  Función:  extracción de la marca de agua por el método |%
%|            de SVD basado en el intercambio de valores.  |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load datosSVDIntercambio.mat;
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'svdIntercambio_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'svdIntercambio_JPEGatack.jpg';
% file_name = 'svdIntercambio_NOISEatack.bmp';
% file_name = 'svdIntercambio_MEANatack.bmp';
% file_name = 'svdIntercambio_CROPPINGatack.bmp';
% file_name = 'svdIntercambio_SCALEDatack.bmp';
% file_name = 'svdIntercambio_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se lee la marca de agua original y se le cambia el tipo a double
file_name = 'mark_64.bmp';
orig_watermark = imread(file_name);

% se determinan las dimensiones de la marca original
[Mo,No] = size(orig_watermark);

% se extrae la marca de agua
watermark = zeros(1,Mo*No*3);
k = 1;
for i = 1:4:Mw
  for j = 1:4:Nw
    A = watermarked_image(i:i+3,j:j+3);
    [U,S,V] = svd(A);

    if((S(2,2)-S(3,3)) > alpha/2)
      watermark(k) = 1;
    else
      watermark(k) = 0;
    end
    k = k+1;
  end
end

marcarecu = zeros(1,Mo*No);
for i = 1:Mo*No
  marcarecu(i) = watermark(i)+watermark(i+Mo*No)+watermark(i+2*Mo*No);
  if(marcarecu(i) >= 2)
    marcarecu(i) = 1;
  else
    marcarecu(i) = 0;
  end
end

% se redimensiona y cambia el tipo de la marca de agua extraida
marcarecu = reshape(marcarecu,[Mo, No]);
marcarecu = uint8(marcarecu)*255;

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(marcarecu,'svdIntercambio_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,marcarecu,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(marcarecu,[])
% title('Marca Recuperada')
