%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dwt_insertar.m                          |%
%|  Función:  inserción de una marca de agua por el método |%
%|            DWT.                                         |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
k = 2;

% se lee la imagen de cobertura y se convierte a tipo double
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se lee la marca de agua y se redimensiona en un vector
file_name = 'copyright_50x20.bmp';
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

% se realiza la transformada de Haar
[cA1,cH1,cV1,cD1] = dwt2(cover_object,'haar');

% se añaden secuencias pn a los componentes H1 y V1 cuando message = 0 
for i = 1:length(message_vector)
  pn_sequence_h = round(2*(rand(Mc/2,Nc/2)-0.5));
  pn_sequence_v = round(2*(rand(Mc/2,Nc/2)-0.5));
  if(message(i) == 0)
    cH1 = cH1+k*pn_sequence_h;
    cV1 = cV1+k*pn_sequence_v;
  end
end

% se realiza la transformada inversa
watermarked_image = idwt2(cA1,cH1,cV1,cD1,'haar',[Mc,Nc]); 

% se convierte la imagen marcada a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'dwt_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
