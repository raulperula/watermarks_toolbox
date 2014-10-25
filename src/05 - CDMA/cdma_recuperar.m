%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: cdma_recuperar.m                        |%
%|  Función:  extracción de la marca de agua por el método |%
%|            CDMA.                                        |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'cdma_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'cdma_JPEGatack.jpg';
% file_name = 'cdma_NOISEatack.bmp';
% file_name = 'cdma_MEANatack.bmp';
% file_name = 'cdma_CROPPINGatack.bmp';
% file_name = 'cdma_SCALEDatack.bmp';
% file_name = 'cdma_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se lee la marca de agua original y se le cambia el tipo a double
file_name = 'copyright_12x9.bmp';
orig_watermark = double(imread(file_name));

% se determinan las dimensiones de la marca original
[Mo,No] = size(orig_watermark);

% se lee la clave para el generador PN
file_name = 'key.bmp';
key = double(imread(file_name))./256;

% se reinicia el generador PN de MATLAB con "key"
rand('state',key(1));

% se inicializa la marca de agua con todo a unos
message_vector = ones(1,Mo*No);
for i = 1:length(message_vector)
  % se genera secuencias PN de valores {-1,0,1}
  pn_sequence = round(2*(rand(Mw,Nw)-0.5));

  % se calcula la correlación
  correlation(i) = corr2(watermarked_image,pn_sequence);
end
    
% se usa como el valor medio de correlación como umbral
threshold = mean(correlation);

% si la correlación excede el umbral, se pone el bit de la marca a cero
for i = 1:length(message_vector)
  if(correlation(i) > threshold)
    message_vector(i) = 0;
  end
end

% se redimensiona la marca para ponerlo como matriz
watermark = reshape(message_vector,Mo,No)*255;

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(watermark,'cdma_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
