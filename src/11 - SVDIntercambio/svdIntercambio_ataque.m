%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svdIntercambio_ataque.m                 |%
%|  Función:  ataque del método SVD basado en el           |%
%|            intercambio de valores.                      |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'svdIntercambio_watermarked.bmp';
watermarked_image = double(imread(file_name));

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(watermarked_image);

% se realiza el ataque
atacada = watermarked_image;
for i = 1:4:Mw
  for j = 1:4:Nw
    A = watermarked_image(i:i+3,j:j+3);
    [U,S,V] = svd(A);
    S(2,2) = S(3,3);
    A = U*S*(V');
    atacada(i:i+3,j:j+3) = A;
  end
end

% se cambia el tipo a unit8
atacada = uint8(atacada);

% se guarda la imagen atacada en un fichero
cd 'ImagenesPruebas'
imwrite(atacada,'svdIntercambio_ataque.bmp');
cd ..

% se muestra la imagen atacada por pantalla
figure
imshow(atacada,[])
title('Imagen Atacada')
