%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: cor_insertar.m                          |%
%|  Función:  inserción de una marca de agua por el método |%
%|            de correlación.                              |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
k = 15;          % se da un valor inicial al factor de ganancia
blocksize = 16; % se pone el tamaño de bloque

% se guardan las variables que harán falta para la extracción
cd 'Datos'
save 'datosCor.mat' blocksize k;
cd ..

% se lee la imagen de cobertura
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se determina el tamaño máximo de la marca basado en las dimensiones de la
% imagen y el tamaño de bloque
max_message = Mc*Nc/(blocksize^2);

% se lee la marca de agua y se convierte a tipo double
file_name = 'copyright_50x20.bmp';
message = double(imread(file_name));
[Mm,Nm] = size(message);

% se redimensiona la marca poniendola como vector
message = round(reshape(message,Mm*Nm,1)./256);

% se comprueba que la marca de agua no sea demasiado grande
if(length(message) > max_message)
  error('Marca de agua demasiado grande.')
end

% se crea la nueva marca con el tamaño máximo establecido con todo a unos
message_pad = ones(1,max_message);
message_pad(1:length(message)) = message;

% se lee una clave para el generador PN
file_name = 'key.bmp';
key = double(imread(file_name))./256;

% se reinicia el generador PN de MATLAB con "key"
rand('state',key(1));

% se genera la marca de agua igual que el tamaño de un bloque
pn_sequence = round(2*(rand(blocksize,blocksize)-0.5));

% se procesa la imagen en bloques, primero se construye la máscara de marca
% global
x = 1;
y = 1;
for kk = 1:length(message_pad)
  % si el bit de la máscara contiene un cero, se añade una secuencia PN
  if(message_pad(kk) == 0)
    watermark_mask(y:y+blocksize-1,x:x+blocksize-1) = pn_sequence;
  % de otra manera, la máscara es rellenada de ceros
  else
    watermark_mask(y:y+blocksize-1,x:x+blocksize-1) = zeros(blocksize,blocksize);
  end

  % se mueve al siquiente bloque
  if((x+blocksize) >= Nc)
    x = 1;
    y = y+blocksize;
  else
    x = x+blocksize;
  end
end

% se añade la máscara de marca a la imagen de cobertura usando el factor de
% ganancia k
watermarked_image_dbl = cover_object+k*watermark_mask;
watermarked_image_int = uint8(cover_object+k*watermark_mask);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'cor_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image_dbl,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
