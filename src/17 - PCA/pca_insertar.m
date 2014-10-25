%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: PCA_insertar.m                          |%
%|  Función:  inserción de una marca de agua por el método |%
%|            PCA.                                         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
p = 64;         % número de componentes principales
alpha = 1;
tam = 1024*16;  % longitud de la marca
key = 250;

% se guardan las variables que harán falta para la extracción
cd 'Datos'
save 'datosPCA.mat' p alpha tam key;
cd ..

% se lee la imagen de cobertura
file_name = 'lena_256.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% la marca sera una secuencia pseudoaleatoria de numeros procedentes de una
% distibucion nomal N(0,1)
randn('state',key);
marca = randn(tam,1);

% se divide la imagen en bloques 8x8, se convierten en vectores 1D
X = zeros(64,1024);
k = 1;
for i = 1:8:Mc
  for j = 1:8:Nc
    A = cover_object(i:i+7,j:j+7);
    A = A(:);
    X(:,k) = A;
    k = k+1;
  end
end

% se calcula la media de las filas
media = mean(X,2);

% a cada columna se le resta la media
X2 = X-repmat(media,[1 1024]);

% se calcula la matriz de proyección: U
[U,S,V] = svds((1/sqrt(1024.))*X2,p);

% se realiza la proyeccion
proy = U'*X2;

% se oculta 16 elementos de la marca en los ultimos 16 elementos
k = 1;
for i = 1:1024
  num = marca(k:k+15);
  proy(49:64,i) = proy(49:64,i)+alpha*proy(49:64,i).*num;
  k = k+16;
end

% se hace la reconstruccion
X3 = U*proy;
X3 = X3+repmat(media,[1 1024]);

% se crea la imagen marcada
imagenmarcada = zeros(Mc,Nc);
k = 1;
for i = 1:8:Mc
  for j = 1:8:Nc
    columna = X3(:,k);
    watermarked_image(i:i+7,j:j+7) = reshape(columna,[8,8]);
    k = k+1;
  end
end

% se convierte la imagen marcada a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'pca_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
