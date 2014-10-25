%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svdArnold_recuperar.m                   |%
%|  Función:  extracción de la marca de agua por el método |%
%|            SVD con la transformada de Arnold.           |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% carga de los datos necesarios para la extracción
cd 'Datos'
load datosSVDArnold.mat;
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'svdArnold_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'svdArnold_JPEGatack.jpg';
% file_name = 'svdArnold_NOISEatack.bmp';
% file_name = 'svdArnold_MEANatack.bmp';
% file_name = 'svdArnold_CROPPINGatack.bmp';
% file_name = 'svdArnold_SCALEDatack.bmp';
% file_name = 'svdArnold_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se lee la marca original y se le cambia el tipo a double
file_name = 'nino_64.bmp';
orig_watermark = double(imread(file_name));

% se determinan las dimensiones de la marca original
[Mo,No] = size(orig_watermark);

% se extrae la marca de la imagen
message_vector = zeros(1,Mo*No);
cont = 1;
for i = 1:8:Mw
  for j = 1:8:Nw
    inter = watermarked_image(i:i+7,j:j+7);
    [U,S,V] = svds(inter,8);
    message_vector(cont) = (S(1,1)-listaS(cont))/alpha;
    cont = cont+1;
  end
end

% se redimensiona la marca para ponerlo como matriz y a tipo uint8
watermark = uint8(reshape(message_vector,[Mo No]));

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(watermark,'svdArnold_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
