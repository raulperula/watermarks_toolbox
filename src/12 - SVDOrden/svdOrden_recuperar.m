%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svOrden_recuperar.m                     |%
%|  Función:  extracción de la marca de agua por el método |%
%|            SVD basado en el orden de los coeficientes.  |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'svdOrden_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'svdOrden_JPEGatack.jpg';
% file_name = 'svdOrden_NOISEatack.bmp';
% file_name = 'svdOrden_MEANatack.bmp';
% file_name = 'svdOrden_CROPPINGatack.bmp';
% file_name = 'svdOrden_SCALEDatack.bmp';
% file_name = 'svdOrden_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se lee la marca da agua original y se convierte a tipo double
file_name = 'hola_32.bmp';
orig_watermark = imread(file_name);

% se determinan las dimensiones de la marca de agua original
[Mo,No] = size(orig_watermark);

% se extrae la marca de agua de la imagen
lista = zeros(1,Mo*No);
k = 1;
for i = 1:8:Mw
  for j = 1:8:Nw
    A = watermarked_image(i:i+7,j:j+7);
    [U,S,V] = svd(A);
    if((U(2,1)-U(3,1)) >= 0)
      lista(k) = 1;
    end
    k = k+1;
  end
end

% se redimensiona y cambia el tipo de la marca de agua extraida
watermark = reshape(lista,[Mo, No])*255;
watermark = uint8(watermark);

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(watermark,'svdOrden_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
