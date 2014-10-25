%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svdOrden_insertar.m                     |%
%|  Función:  inserción de una marca de agua por el método |%
%|            SVD basado en el orden de los coeficientes.  |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen de cobertura
file_name = 'lena_256.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se lee la marca de agua
file_name = 'hola_32.bmp';
marca = imread(file_name)/255;
marca = marca(:);

% se establece el valor del umbral
T = 0.012;

% se crea la imagen marcada
watermarked_image = cover_object;
l = 1;
for i = 1:8:Mc
  for j = 1:8:Nc
    bit = marca(l);
    A = cover_object(i:i+7,j:j+7);
    [U,S,V] = svd(A);
    udif = U(2,1)-U(3,1);
    ptomedio = (U(2,1)+U(3,1))/2;
    if((bit == 1) && (udif < T))
      U(2,1) = ptomedio+T/2;
      U(3,1) = ptomedio-T/2;
    end
    if((bit == 0) && (udif > -T))
      U(2,1) = ptomedio-T/2;
      U(3,1) = ptomedio+T/2;
    end
    l = l+1;
    B = U*S*(V');
    watermarked_image(i:i+7,j:j+7) = B;
  end
end

% se convierte la imagen marcada a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'svdOrden_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
