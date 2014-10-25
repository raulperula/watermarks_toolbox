%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: PCAReferencia_recuperar.m               |%
%|  Función:  extracción de la marca de agua por el método |%
%|            PCA para construir la imagen de referencia.  |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load 'datosPCAReferencia.mat'
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'pcaReferencia_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'pcaReferencia_JPEGatack.jpg';
% file_name = 'pcaReferencia_NOISEatack.bmp';
% file_name = 'pcaReferencia_MEANatack.bmp';
% file_name = 'pcaReferencia_CROPPINGatack.bmp';
% file_name = 'pcaReferencia_SCALEDatack.bmp';
% file_name = 'pcaReferencia_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se calcula la imagen de referencia usando PCA con la imagen marcada
media = mean(watermarked_image,2);
X = watermarked_image-repmat(media,[1 Nw]);
H = (1/sqrt(Nw))*X;
[U,S,V] = svds(H,b);
proy = (U')*X;
recons = U*proy+repmat(media,[1 Nw]);
referencia = recons;

% se crea la marca que son 'tam' bits pseudoaleatorios
rand('state',key); 
orig_watermark = ceil(2*rand(tam,1)-1);

% se hace una permutacion aleatoria para escoger aquellos coeficientes donde
% se va a ocultar la marca
contador = size(idx,1);
permuta1 = randperm(contador);
permuta = permuta1(1:tam);

% se extrae la marca
watermark = zeros(tam,1);
for k = 1:tam
  pos = permuta(k);
  vector = idx(pos,:);
  i = vector(1);
  j = vector(2);
  if(watermarked_image(i,j) > referencia(i,j))
    watermark(k) = 1;
  end
end

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errVector(orig_watermark,watermark,tam);

% se calcula la similaridad
graf = similaridad(orig_watermark,watermark,tam);
title('Similaridad');

% se guarda la gráfica en un fichero
cd 'ImagenesPruebas'
I = getframe(gcf);
imwrite(I.cdata,'pcaReferencia_similaridad.bmp');
cd ..
