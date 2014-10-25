%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dctcor_insertar.m                       |%
%|  Función:  inserción de una marca de agua por el método |%
%|            DCT haciendo uso de la correlacion.          |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
k = 10;                        % factor de ganancia
blocksize = 8;                % tamaño de bloque
pn_sequence_search = 'T';     % búsqueda para encontrar baja correlaciónentre pn 
                              % sequences {T,F}

% se guardan las variables que harán falta para la extracción
cd 'Datos'
save 'datosDCTCor.mat' blocksize pn_sequence_search;
cd ..

% se definen las frecuencias de banda media del dct 8x8
midband = [ 0,0,0,1,1,1,1,0;
            0,0,1,1,1,1,0,0;
            0,1,1,1,1,0,0,0;
            1,1,1,1,0,0,0,0;
            1,1,1,0,0,0,0,0;
            1,1,0,0,0,0,0,0;
            1,0,0,0,0,0,0,0;
            0,0,0,0,0,0,0,0 ];
        
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

% reshape the message to a vector
message = round(reshape(message,Mm*Nm,1)./256);

% se comprueba que la marca de agua no sea demasiado grande
if(length(message) > max_message)
  error('Marca de agua demasiado grande.')
end

% se crea la nueva marca con el tamaño máximo establecido con todo a unos
message_vector = ones(1,max_message);
message_vector(1:length(message)) = message;

% se genera una copia de la imagen marcada
watermarked_image = cover_object;

% se lee una clave para el generador PN
file_name = 'key.bmp';
key = double(imread(file_name))./256;

% se reinicia el generador PN de MATLAB con "key"
rand('state',key(1));

% se generan PN secuencias de "1" y "0"
pn_sequence_one = round(2*(rand(1,sum(sum(midband)))-0.5));
pn_sequence_zero = round(2*(rand(1,sum(sum(midband)))-0.5));

% find two highly un-correlated PN sequences
if(pn_sequence_search == 'T')
  while(corr2(pn_sequence_one,pn_sequence_zero) > -0.55)
    pn_sequence_one = round(2*(rand(1,sum(sum(midband)))-0.5));
    pn_sequence_zero = round(2*(rand(1,sum(sum(midband)))-0.5));
  end
end
    
% se procesa la imagen en bloques
x = 1;
y = 1;
for kk = 1:length(message_vector)
  % bloque transformado usando DCT
  dct_block = dct2(cover_object(y:y+blocksize-1,x:x+blocksize-1));

  % si el bit de la marca de agua contiene un cero entonces se oculta en
  % pn_sequence_zero en los componentes de banda media del dct_block
  ll = 1;
  if(message_vector(kk) == 0)
    for ii = 1:blocksize
      for jj = 1:blocksize
        if(midband(jj,ii) == 1)
          dct_block(jj,ii) = dct_block(jj,ii)+k*pn_sequence_zero(ll);
          ll = ll+1;
        end
      end
    end

  % en otro caso, se oculta pn_sequence_one en los componentes de banda
  % media de dct_block
  else
    for ii = 1:blocksize
      for jj = 1:blocksize
        if(midband(jj,ii) == 1)
          dct_block(jj,ii) = dct_block(jj,ii)+k*pn_sequence_one(ll);
          ll = ll+1;
        end
      end
    end
  end

  % se transforma el bloque al dominio espacial
  watermarked_image(y:y+blocksize-1,x:x+blocksize-1)=idct2(dct_block);    

  % se mueve al siguiente bloque
  if((x+blocksize) >= Nc)
    x = 1;
    y = y+blocksize;
  else
    x = x+blocksize;
  end
end

% se convierte la imagen marcada a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'dctcor_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
