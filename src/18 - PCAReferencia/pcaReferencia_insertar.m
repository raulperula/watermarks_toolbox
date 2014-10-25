%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: PCAReferencia_insertar.m                |%
%|  Función:  inserción de una marca de agua por el método |%
%|            PCA para construir la imagen de referencia.  |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
b = 10;
s = 1;
t = 3;
tam = 1000;
alpha = (s+t)/2;
key = 250.;

% se lee la imagen de cobertura
file_name = 'lena_256.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se calcula de la imagen de referencia usando PCA con la imagen completa
% si b = 256, la imagen obtenida en recons2 es la original
media = mean(cover_object,2);
X = cover_object-repmat(media,[1 Nc]);
H = (1/sqrt(Nc))*X;
[U,S,V] = svds(H,b);
proy = (U')*X;
recons = U*proy+repmat(media,[1 Nc]);

% se calcula cuantos elementos de la imagen sirven
referencia = recons;
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

% se guardan las variables que harán falta para la extracción
cd 'Datos'
save datosPCAReferencia.mat b s t tam alpha idx key;
cd ..

% se crea la marca, siendo esta 'tam' bits pseudoaleatorios
rand('state',key); 
marca = ceil(2*rand(tam,1)-1);

% se realiza una permutación aleatoria para escoger aquellos coeficientes donde
% se va a ocultar la marca
permuta1 = randperm(contador);
permuta = permuta1(1:tam);

% se crea la imagen marcada
watermarked_image = cover_object;
for k = 1:tam
  pos = permuta(k);
  vector = idx(pos,:);
  i = vector(1);
  j = vector(2);
  bit = marca(k);
  if((cover_object(i,j) <= referencia(i,j)) && (bit == 1))
    watermarked_image(i,j) = referencia(i,j)+alpha;
  end
  if((cover_object(i,j) > referencia(i,j)) && (bit == 0))
    watermarked_image(i,j) = referencia(i,j)-alpha;
  end
end

% se convierte la imagen marcada a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'pcaReferencia_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
