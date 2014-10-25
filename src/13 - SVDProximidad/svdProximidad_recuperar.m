%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svdProximidad_recuperar.m               |%
%|  Función:  extraccion de la marca de agua por el método |%
%|            SVD basado en la proximidad a un intervalo.  |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load 'datosSVDProximidad.mat'
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'svdProximidad_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'svdProximidad_JPEGatack.jpg';
% file_name = 'svdProximidad_NOISEatack.bmp';
% file_name = 'svdProximidad_MEANatack.bmp';
% file_name = 'svdProximidad_CROPPINGatack.bmp';
% file_name = 'svdProximidad_SCALEDatack.bmp';
% file_name = 'svdProximidad_ROTATEatack.bmp';
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

% se extrae la marca de agua
extraida = zeros(1,Mo*No);
k = 1;
for i = 1:8:Mw
  for j = 1:8:Nw
    A = watermarked_image(i:i+7,j:j+7);
    [U,S,V] = svd(A);
    % se averigua en que subintervalo se encuentra
    h = floor((S(1,1)-limiteinferior)/T)+1;
    if(h == 0)
      h = 1;
    end
    ptomedio = (bin(h,2)+bin(h,1))/2;
    if(S(1,1) < ptomedio)
      extraida(k) = 1;
    end
    k = k+1;
  end
end

% se redimensiona la marca de agua en forma de matriz
watermark = reshape(extraida,[Mo, No])*255;

% se guarda la marca de agua en un fichero
cd 'ImagenesPruebas'
imwrite(watermark,'svdProximidad_watermark.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el número de errores que contiene la marca extraida
errMatriz(orig_watermark,watermark,Mo,No);

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermark,[])
% title('Marca Recuperada')
