%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: scdct_recuperar.m                       |%
%|  Función:  extracción de la marca de agua por el método |%
%|            de las secuencias caoticas y la DCT.         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load 'datosSCDCT.mat'
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'scdct_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'scdct_JPEGatack.jpg';
% file_name = 'scdct_NOISEatack.bmp';
% file_name = 'scdct_MEANatack.bmp';
% file_name = 'scdct_CROPPINGatack.bmp';
% file_name = 'scdct_SCALEDatack.bmp';
% file_name = 'scdct_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se genera la marca con números pseudoaleatorios de una N(0,1)
randn('state',key);
orig_watermark = randn(tam,1);

ma = [1 1; 2 3];      % matriz inicial
K = [115 84;168 27];  % matriz para realizar la permutación directamente

% se realizan las 42 iteraciones de Arnold
permutada = zeros(Mw,Nw);
for i = 1:Mw
  for j = 1:Nw
    ic = i-1;
    jc = j-1;
    nuevos = mod(K*[ic;jc],256);
    permutada(nuevos(1)+1,nuevos(2)+1) = watermarked_image(i,j);
  end
end
  
% se calcula la DCT
trans = dct2(permutada);

% se extraen los coeficientes en zig-zag, se extraen los coefcientes DCT
% que se usaron para ocultar la marca
watermark = zeros(tam,1);
k = 1;
for i = 2:Mw
  for j = 1:i
    if(k <= tam)
      watermark(k) = trans(i,j);
      k = k+1;
    end
  end
end

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula la similaridad
graf = correlacion(orig_watermark,watermark,tam,1);
title('Correlacion');

% se guarda la gráfica en un fichero
cd 'ImagenesPruebas'
I = getframe(gcf);
imwrite(I.cdata,'scdct_correlacion.bmp');
cd ..
