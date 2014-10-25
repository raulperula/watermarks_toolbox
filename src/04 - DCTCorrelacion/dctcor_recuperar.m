%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dctcor_recuperar.m                      |%
%|  Función:  extracción de la marca de agua por el método |%
%|            DCT basado en la correlacion.                |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load 'datosDCTCor.mat'
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se definen las frecuencias de banda media del dct 8x8
midband = [ 0,0,0,1,1,1,1,0;
            0,0,1,1,1,1,0,0;
            0,1,1,1,1,0,0,0;
            1,1,1,1,0,0,0,0;
            1,1,1,0,0,0,0,0;
            1,1,0,0,0,0,0,0;
            1,0,0,0,0,0,0,0;
            0,0,0,0,0,0,0,0 ];
        
% se lee la imagen marcada y se convierte a tipo double
% file_name = 'dctcor_watermarked.bmp';
% watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'dctcor_JPEGatack.jpg';
% file_name = 'dctcor_NOISEatack.bmp';
% file_name = 'dctcor_MEANatack.bmp';
% file_name = 'dctcor_CROPPINGatack.bmp';
% file_name = 'dctcor_SCALEDatack.bmp';
file_name = 'dctcor_ROTATEatack.bmp';
cd 'ImagenesAtaques'
watermarked_image = double(imread(file_name));
cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se determina el tamaño maximo de la marca de agua basado en la imagen de
% cobertura y el tamaño de bloque
max_message = Mw*Nw/(blocksize^2);

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

% se generan PN secuencias de "1" y "0"
pn_sequence_one = round(2*(rand(1,sum(sum(midband)))-0.5));
pn_sequence_zero = round(2*(rand(1,sum(sum(midband)))-0.5));

% se encuentras dos PN secuencias altamente no correlacionadas
if(pn_sequence_search == 'T')
  while(corr2(pn_sequence_one,pn_sequence_zero) > -0.55)
    pn_sequence_one = round(2*(rand(1,sum(sum(midband)))-0.5));
    pn_sequence_zero = round(2*(rand(1,sum(sum(midband)))-0.5));
  end
end

% se procesa la imagen en bloques
x = 1;
y = 1;
for kk = 1:max_message
  % bloque transformado usando DCT
  dct_block = dct2(watermarked_image(y:y+blocksize-1,x:x+blocksize-1));

  % se extrae los coeficientes de la manda media
  ll = 1;
  for ii = 1:blocksize
    for jj = 1:blocksize
      if(midband(jj,ii) == 1)
        sequence(ll) = dct_block(jj,ii);
        ll = ll+1;
      end
    end
  end

  % se calcula la correlación de la secuencia de banda media con pn_sequences
  % y se elige el valor con la mayor correlación de la marca
  cor_one(kk) = corr2(pn_sequence_one,sequence);
  cor_zero(kk) = corr2(pn_sequence_zero,sequence);
  if(cor_zero(kk) > cor_one(kk))
    message_vector(kk) = 0;
  else
    message_vector(kk) = 1;
  end

  % se mueve al siguiente bloque
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
imwrite(watermark,'dctcor_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
