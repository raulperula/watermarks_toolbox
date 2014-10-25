%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dct_recuperar.m                         |%
%|  Función:  extracción de la marca de agua por el método |%
%|            DCT.                                         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load 'datosDCT.mat'
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se convierte a tipo double
% file_name = 'dct_watermarked.bmp';
% watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'dct_JPEGatack.jpg';
% file_name = 'dct_NOISEatack.bmp';
% file_name = 'dct_MEANatack.bmp';
% file_name = 'dct_CROPPINGatack.bmp';
% file_name = 'dct_SCALEDatack.bmp';
file_name = 'dct_ROTATEatack.bmp';
cd 'ImagenesAtaques'
watermarked_image = double(imread(file_name));
cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se determina el tamaño maximo de la marca de agua basado en la imagen de
% cobertura y el tamaño de bloque
max_message = Mw*Nw/(blocksize^2);

% se lee la marca da agua original y se convierte a tipo double
file_name = 'copyright_50x20.bmp';
orig_watermark = double(imread(file_name));

% se determinan las dimensiones de la marca de agua original
[Mo,No] = size(orig_watermark);

% se procesa la imagen en bloques
x = 1;
y = 1;
for i = 1:max_message
  % bloque transformado usando DCT
  dct_block = dct2(watermarked_image(y:y+blocksize-1,x:x+blocksize-1));

  % si dct_block(5,2) > dct_block(4,3) entonces message(i) = 0
  % de otro modo message(i) = 1
  if(dct_block(5,2) > dct_block(4,3))
    message_vector(i) = 0;
  else
    message_vector(i) = 1;
  end

  % se mueve al bloque siguiente
  if((x+blocksize) >= Nw)
    x = 1;
    y = y+blocksize;
  else
    x = x+blocksize;
  end
end

% se redimensiona la marca de agua en forma de matriz
watermark = reshape(message_vector(1:Mo*No),Mo,No)*255;

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(watermark,'dct_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
