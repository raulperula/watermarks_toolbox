%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dct_insertar.m                          |%
%|  Función:  inserción de una marca de agua por el método |%
%|            DCT.                                         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
k = 10;         % factor de ganancia
blocksize = 8;  % tamaño del bloque

% se guardan las variables que harán falta para la extracción
cd 'Datos'
save 'datosDCT.mat' blocksize;
cd ..

% se lee la imagen de cobertura y se convierte a tipo double
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se determina el tamaño maximo de la marca de agua basado en la imagen de
% cobertura y el tamaño de bloque
max_message = Mc*Nc/(blocksize^2);

% se lee la marca de agua y se convierte a tipo double
file_name = 'copyright_50x20.bmp';
message = double(imread(file_name));

% se determinan las dimensiones de la marca de agua
[Mm,Nm] = size(message);

% se redimensiona la marca de agua en forma de vector
message = round(reshape(message,Mm*Nm,1)./256);

% se comprueba que la marca de agua no sea demasiado grande
if(length(message) > max_message)
  error('Marca de agua demasiado grande.')
end

% se crea la nueva marca con el tamaño máximo establecido con todo a unos
message_pad = ones(1,max_message);
message_pad(1:length(message)) = message;

% se genera una copia de la imagen marcada
watermarked_image = cover_object;

% se procesa la imagen en bloques codificados tal que (5,2) > (4,3) cuando
% message(kk) = 0 y que (5,2) < (4,3) cuando message(kk) = 1
x = 1;
y = 1;
for i = 1:length(message_pad)
  % bloque transformado usando DCT
  dct_block = dct2(cover_object(y:y+blocksize-1,x:x+blocksize-1));

  % si el bit de la marca es cero, (5,2) > (4,3)
  if(message_pad(i) == 0)
    % si (5,2) < (4,3) entonces se necesita intercambiar las posiciones
    if (dct_block(5,2) < dct_block(4,3))
      temp = dct_block(4,3);
      dct_block(4,3) = dct_block(5,2);
      dct_block(5,2) = temp;
    end
  % si el bit de la marca es uno, (5,2) < (4,3)
  elseif(message_pad(i) == 1)
    % si (5,2) > (4,3) entonces se necesita intercambiar las posiciones
    if(dct_block(5,2) >= dct_block(4,3))
      temp = dct_block(4,3);
      dct_block(4,3) = dct_block(5,2);
      dct_block(5,2) = temp;
    end
  end

  % ahora se ajustan los dos valores tal que su diferencia sea >= k
  if(dct_block(5,2) > dct_block(4,3))
    if(dct_block(5,2) - dct_block(4,3) < k)
      dct_block(5,2) = dct_block(5,2)+(k/2);
      dct_block(4,3) = dct_block(4,3)-(k/2);
    end
  else
    if(dct_block(4,3) - dct_block(5,2) < k)
      dct_block(4,3) = dct_block(4,3)+(k/2);  
      dct_block(5,2) = dct_block(5,2)-(k/2);
    end
  end

  % se transforma el bloque al dominio espacial
  watermarked_image(y:y+blocksize-1,x:x+blocksize-1) = idct2(dct_block);    

  % se mueve al siguiente bloque
  if((x+blocksize) >= Nc)
    x = 1;
    y = y+blocksize;
  else
    x = x+blocksize;
  end
end

% se convierte la imagen marcada a tipo uint8 y se guarda en un fichero
watermarked_image_int = uint8(watermarked_image);
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'dct_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
