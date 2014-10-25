%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: cdma_insertar.m                         |%
%|  Función:  inserción de una marca de agua por el método |%
%|            CDMA.                                        |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se da un valor inicial al factor de ganancia
k = 2;

% se lee la imagen de cobertura
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se lee la marca de agua y se redimensiona poniendolo como un vector
file_name = 'copyright_12x9.bmp';
message = double(imread(file_name));

% se determinan las dimensiones de la marca de agua
[Mm,Nm] = size(message);

% se redimensiona la marca en forma de vector binario
message_vector = round(reshape(message,Mm*Nm,1)./256);

% se lee una clave para el generador PN
file_name = 'key.bmp';
key = double(imread(file_name))./256;

% se reinicia el generador PN de MATLAB con "key"
rand('state',key(1));

% se crea una copia de la imagen
watermarked_image = cover_object;

% cuando la marca contiene un '0', se añade una secuencia pn con un factor
% de ganancia k para la imagen de cobertura
for i = 1:length(message_vector)
  pn_sequence = round(2*(rand(Mc,Nc)-0.5));
  if(message(i) == 0)
    watermarked_image = watermarked_image+k*pn_sequence;
  end
end

% se convierte la marca de agua a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'cdma_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
