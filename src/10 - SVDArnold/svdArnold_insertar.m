%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svdArnold_insertar.m                    |%
%|  Función:  inserción de una marca de agua por el método |%
%|            SVD con la transformada de Arnold.           |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se lee la imagen de cobertura
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se lee la marca de agua y se redimensiona poniendolo como un vector
file_name = 'nino_64.bmp';
message = double(imread(file_name));

% se determinan las dimensiones de la marca de agua
[Mm,Nm] = size(message);

% se redimensiona la marca en forma de vector
message = message(:);

% se crea la imagen marcada
watermarked_image = zeros(Mc,Nc);
alpha = 0.3;
cont = 1;
listaS = zeros(1,Mm*Nm);
for i = 1:8:Mc
  for j = 1:8:Nc
    inter = cover_object(i:i+7,j:j+7);
    [U,S,V] = svds(inter,8);
    listaS(cont) = S(1,1);
    S(1,1) = S(1,1)+alpha*message(cont);
    cont = cont+1;
    watermarked_image(i:i+7,j:j+7) = U*S*(V');
  end
end

% se guardan los parámetros que harán falta para la extracción
cd 'Datos'
save datosSVDArnold.mat listaS alpha;
cd ..

% se convierte la marca de agua a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'svdArnold_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
