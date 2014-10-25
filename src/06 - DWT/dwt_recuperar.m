%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dwt_recuperar.m                         |%
%|  Función:  extracción de la marca de agua por el método |%
%|            DWT.                                         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se convierte a tipo double
file_name = 'dwt_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'dwt_JPEGatack.jpg';
% file_name = 'dwt_NOISEatack.bmp';
% file_name = 'dwt_MEANatack.bmp';
% file_name = 'dwt_CROPPINGatack.bmp';
% file_name = 'dwt_SCALEDatack.bmp';
% file_name = 'dwt_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se lee la marca de agua original y se convierte a tipo double
file_name = 'copyright_50x20.bmp';
orig_watermark = double(imread(file_name));

% se determinan las dimensiones de la marca de agua original
[Mo,No] = size(orig_watermark);

% se lee una clave para el generador PN
file_name = 'key.bmp';
key = double(imread(file_name))./256;

% se reinicia el generador PN de MATLAB con "key"
rand('state',key(1));

% se inicializa la marca con todo a unos
message_vector = ones(1,Mo*No);

% se realiza la transformada de Haar
[cA1,cH1,cV1,cD1] = dwt2(watermarked_image,'haar');

% se añaden secuencias pn a los componentes H1 y V1 cuando message = 0 
for i = 1:length(message_vector)
  pn_sequence_h = round(2*(rand(Mw/2,Nw/2)-0.5));
  pn_sequence_v = round(2*(rand(Mw/2,Nw/2)-0.5));

  correlation_h(i) = corr2(cH1,pn_sequence_h);
  correlation_v(i) = corr2(cV1,pn_sequence_v);
  correlation(i) = (correlation_h(i)+correlation_v(i))/2;
end

% si la correlación excede el umbral, se pone el bit a '0'
for i = 1:length(message_vector)
  if(correlation(i) > mean(correlation))
    message_vector(i) = 0;
  end
end

% se redimensiona la marca de agua en forma de matriz
watermark = reshape(message_vector,Mo,No)*255;

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(watermark,'dwt_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
