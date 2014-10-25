%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svdProximidad_insertar.m                |%
%|  Función:  inserción de una marca de agua por el método |%
%|            SVD basado en la proximidad a un intervalo.  |%
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

% se lee la marca de agua y se convierte a tipo double
file_name = 'hola_32.bmp';
watermark = imread(file_name)/255;

% se determinan las dimensiones de la marca de agua
[Mm,Nm] = size(watermark);
watermark = watermark(:);

% se extraen los valores singulares
k = 1;
lista = zeros(1,Mm*Nm);
for i = 1:8:Mc
  for j = 1:8:Nc
    A = cover_object(i:i+7,j:j+7);
    [U,S,V] = svd(A);
    lista(k) = S(1,1);
    k = k+1;
  end
end

T = 60;
dmin = min(lista);
dmax = max(lista);
n = floor((dmax-dmin+2*T)/T)+1;

bin = zeros(n,2);
bin(1,1) = dmin-T;
bin(1,2) = dmin;
for i = 2:n
  bin(i,1) = bin(i-1,2);
  bin(i,2) = bin(i,1)+T;
end

% se crea la imagen marcada
watermarked_image = cover_object;
k = 1;
limiteinferior = dmin-T;
for i = 1:8:Mc
  for j = 1:8:Nc
    A = cover_object(i:i+7,j:j+7);
    [U,S,V] = svd(A);
    % se averigua en que subintervalo se encuentra
    h = floor((S(1,1)-limiteinferior)/T);
    bit = watermark(k);
    if(bit == 1)
      S(1,1) = (bin(h,1)+(bin(h,2)+bin(h,1))/2)/2;
    else
      S(1,1) = (bin(h,2)+(bin(h,2)+bin(h,1))/2)/2;
    end
    Amod = U*S*(V');
    watermarked_image(i:i+7,j:j+7) = Amod;
    k = k+1;
  end
end

% se guardan los parámetros que harán falta para la extracción
cd 'Datos'
save 'datosSVDProximidad.mat' bin limiteinferior T;
cd ..

% se convierte la imagen marcada a tipo uint8
watermarked_image_int = uint8(watermarked_image);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'svdProximidad_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
