%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: SC_recuperar.m                          |%
%|  Función:  extracción de la marca de agua por el método |%
%|            de las secuencias caóticas.                  |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se cargan los datos necesarios para la extracción
cd 'Datos'
load datosSC.mat;
cd ..

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'sc_watermarked.bmp';
watermarked_image = double(imread(file_name));

% carga de las imágenes atacadas
% file_name = 'sc_JPEGatack.jpg';
% file_name = 'sc_NOISEatack.bmp';
% file_name = 'sc_MEANatack.bmp';
% file_name = 'sc_CROPPINGatack.bmp';
% file_name = 'sc_SCALEDatack.bmp';
% file_name = 'sc_ROTATEatack.bmp';
% cd 'ImagenesAtaques'
% watermarked_image = double(imread(file_name));
% cd ..

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se hace la simulación utilizando el vector de correlaciones entre las
% marcas creadas y la original
corre = zeros(1,50);
for k = 1:50
  x = zeros(1,Mw*Nw);
  x(1) = double(k);
  x(1) = x(1)/100;
  for i = 2:Mw*Nw
    x(i) = lambda*x(i-1)*(1-x(i-1));
  end
  
  w = zeros(1,Mw*Nw);
  for i = 1:Mw*Nw
    if(x(i) < umbral)
      w(i) = 1;
    end
  end
  
  W = reshape(w,[Mw,Nw]);
  
  % se crea el vector de correlaciones de la imagen marcada con las marcas
  corre(k) = corr2(W,watermarked_image);
end

x = 1:50;
graf = plot(x,corre);
title('Correlacion');

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se guarda la gráfica en un fichero
cd 'ImagenesPruebas'
I = getframe(gcf);
imwrite(I.cdata,'sc_correlacion.bmp');
cd ..
