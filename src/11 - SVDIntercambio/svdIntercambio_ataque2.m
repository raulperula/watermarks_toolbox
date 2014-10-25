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

% se inicializa el parámetro necesario
alpha = 20;

% se lee la imagen marcada y se le cambia el tipo a double
file_name = 'svdIntercambio_watermarked.bmp';
image = double(imread(file_name));

% se determinan las dimensiones de la imagen marcada
[Mw,Nw] = size(image);

% se lee la marca de agua original y se le cambia el tipo a double
file_name = 'EPS_64.bmp';
marca = double(imread(file_name));
marca = marca(:)/255.;
marca = [marca marca marca marca];

% se realiza el ataque
watermarked_image = zeros(Mw,Nw);
k = 1;
for i = 1:4:Mw
    for j = 1:4:Nw
        A = image(i:i+3,j:j+3);
        bit = marca(k);
        [U,S,V] = svd(A);
        S(3,3) = S(2,2);
        S(2,2) = S(2,2)+alpha*bit;
        if(S(1,1) < S(2,2))
            S(1,1) = S(2,2);
        end
        Amod = U*S*(V');
        watermarked_image(i:i+3,j:j+3) = Amod;
        k = k+1;
    end
end

% se cambia el tipo a unit8
watermarked_image = uint8(watermarked_image);

% se guarda la imagen atacada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image,'svdIntercambio_ataque2.bmp');
cd ..

% se muestra la imagen atacada por pantalla
figure
imshow(watermarked_image,[])
title('Imagen Atacada')
