%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dwtHaar_insertar.m                      |%
%|  Función:  inserción de una marca de agua por el método |%
%|            de la DWT con la transformada de Haar.       |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
key = 250;
tam = 1000;
s = 1;
t = 5;
alpha = (s+t)/2;

% se lee la imagen de cobertura
file_name = 'lena_256.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se realiza la DWT con la transformada de Haar
[LL,H,V,D] = dwt2(cover_object,'haar');

% se crea el bloque que contiene todo ceros
ceros = zeros(Mc/2,Nc/2);

% se hace la DWT inversa para crear la imagen de referencia la cual solo
% contendrá las frecuencias bajas, LL, y el resto a ceros
referencia = idwt2(LL,ceros,ceros,ceros,'haar');

%se calcula cuántos elementos de la imagen sirven y su índice
contador = 0;
idx = [];
for i = 1:Mc
  for j = 1:Nc
    if((abs(cover_object(i,j)-referencia(i,j)) > s) && (abs(cover_object(i,j)-referencia(i,j)) < t))
      idx = [idx;[i j]];
      contador = contador+1;
    end
  end
end

% se guarda lo calculado ya que hará falta para la extracción
cd 'Datos'
save 'datosDWTHaar.mat' contador idx key tam;
cd ..

% se reinicia el generador PN de MATLAB con "key"
rand('state',key);

% se crea la marca con 1000 números aleatorios
marca = ceil(2*rand(tam,1)-1);
 
% se hace una permutación aleatoria para escoger aquellos coeficientes
% donde se va a ocultar la marca
permuta1 = randperm(contador);
permuta = permuta1(1:tam);

% se crea la imagen marcada
watermarked_image = cover_object;
for k = 1:tam
  l = permuta(k);
  vector = idx(l,:);
  i = vector(1);
  j = vector(2);
  bit = marca(k);
  if((cover_object(i,j) >= referencia(i,j)) && (bit == 0))
    watermarked_image(i,j) = referencia(i,j)-alpha;
  end
  if((cover_object(i,j) < referencia(i,j)) && (bit == 1))
    watermarked_image(i,j) = referencia(i,j)+alpha;
  end
end

% se convierte la marca de agua a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'dwtHaar_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
