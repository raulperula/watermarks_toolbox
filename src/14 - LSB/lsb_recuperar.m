%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: lsb_recuperar.m                         |%
%|  Función:  extracción de la marca de agua por el método |%
%|            LSB.                                         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada
file_name = 'lsb_watermarked.bmp';
watermarked_image = imread(file_name);

% carga de las imágenes atacadas
% file_name = 'lsb_JPEGatack.jpg';
% file_name = 'lsb_NOISEatack.bmp';
% file_name = 'lsb_MEANatack.bmp';
% file_name = 'lsb_CROPPINGatack.bmp';
% file_name = 'lsb_SCALEDatack.bmp';
% file_name = 'lsb_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se lee la marca de agua original y se convierte a tipo double
file_name = 'copyright_512.bmp';
orig_watermark = double(imread(file_name));

% se determinan las dimensiones de la marca original
[Mo,No] = size(orig_watermark);

% se usan los lsb de la imagen marcada para recuperar la marca de agua
for i = 1:Mw
  for j = 1:Nw
    watermark(i,j) = bitget(watermarked_image(i,j),1);
  end
end

% se escala la marca de agua recuperada
watermark = double(watermark)*255;

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(watermark,'lsb_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
