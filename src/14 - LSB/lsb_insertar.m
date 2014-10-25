%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: lsb_insertar.m                          |%
%|  Función:  inserción de una marca de agua por el método |%
%|            LSB.                                         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen de cobertura
file_name = 'lena_512.bmp';
cover_object = imread(file_name);

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se lee la marca de agua
file_name = 'copyright_50x20.bmp';
message = imread(file_name);

% se convierte la marca a tipo double para normalizarla, después se vuelve
% a convertir a tipo uint8
message = double(message);
message = round(message./256);
message = uint8(message);

% se determinan las dimensiones de la marca
[Mm,Nm] = size(message);

% se crea la nueva marca a partir de la marca anterior, se repite esta
% hasta que tenga el mismo tamaño que la imagen original
for i = 1:Mc
  for j = 1:Nc
    watermark(i,j) = message(mod(i,Mm)+1, mod(j,Nm)+1);
  end
end

% ahora se ponen los lsb de cover_object(i,j) para los valores de
% watermark(i,j)
watermarked_image = cover_object;
for i = 1:Mc
  for j = 1:Nc
    watermarked_image(i,j) = bitset(watermarked_image(i,j),1,watermark(i,j));
  end
end

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image,'lsb_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image,[])
% title('Imagen Marcada')
