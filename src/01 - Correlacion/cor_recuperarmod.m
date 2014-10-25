%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: cor_recuperarmod.m                      |%
%|  Función:  extracción de la marca de agua por el método |%
%|            de correlación modificado.                   |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los parámetros necesarios para la extracción
cd 'Datos'
load 'datosCor.mat'
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'cor_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'cor_JPEGatack.jpg';
% file_name = 'cor_NOISEatack.bmp';
% file_name = 'cor_MEANatack.bmp';
% file_name = 'cor_CROPPINGatack.bmp';
% file_name = 'cor_SCALEDatack.bmp';
% file_name = 'cor_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se lee la imagen original y se le cambia el tipo a double
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se determina el máximo tamaño posible de la marca de agua
max_message = Mw*Nw/(blocksize^2);

% se lee la marca de agua original y se le cambia el tipo a double
file_name = 'copyright_50x20.bmp';
orig_watermark = double(imread(file_name));

% se determinan las dimensiones de la marca original
[Mo,No] = size(orig_watermark);

% se lee la clave para el generador PN
file_name = 'key.bmp';
key = double(imread(file_name))./256;

% se reinicia el generador PN de MATLAB con "key"
rand('state',key(1));

% se genera una marca igual al tamaño del bloque
pn_sequence = round(2*(rand(blocksize,blocksize)-0.5));

% se inicializa la marca de agua con todo a unos
message_vector = ones(No*Mo,1);

% se calcula la marca
W = (watermarked_image-cover_object)./k;

% se procesa la imagen en bloques, para cada bloque se determina su
% correlación con la secuencia pn base pn
x = 1;
y = 1;
ceros = zeros(blocksize,blocksize);
for kk = 1:length(message_vector)   
  bloque = W(y:y+blocksize-1,x:x+blocksize-1);
  error1 = sum(sum((bloque-pn_sequence).^2));
  error2 = sum(sum((bloque-ceros).^2));
  if(error1 < error2) 
    message_vector(kk) = 0;
  else
    message_vector(kk) = 1;
  end  

  % se mueve al siguiente bloque
  if ((x+blocksize) >= Nw)
    x = 1;
    y = y+blocksize;
  else
    x = x+blocksize;
  end
end

% se redimensiona la marca para ponerla como matriz
watermark = reshape(message_vector(1:Mo*No),Mo,No)*255;

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(watermark,'cor_watermarkMod.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
