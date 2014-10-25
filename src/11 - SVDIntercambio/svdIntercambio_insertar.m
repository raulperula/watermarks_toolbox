%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: svdIntercambio_insertar.m               |%
%|  Función:  inserción de una marca de agua por el método |%
%|            SVD basado en el intercambio de valores.     |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializa el parámetro necesario
alpha = 2;

% se guarda el parametro necesario para la extracción
cd 'Datos'
save datosSVDIntercambio.mat alpha;
cd ..

% se lee la imagen de cobertura
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se lee la marca de agua y se convierte a tipo double, la marca que se
% insertara sera la repeticion de la original
file_name = 'mark_64.bmp';
marca = double(imread(file_name));
marca = marca(:)/255.;
marca = [marca marca marca marca];

% se crea la imagen marcada
watermarked_image_dbl = zeros(512,512);
k = 1;
for i = 1:4:512
  for j = 1:4:512
    A = cover_object(i:i+3,j:j+3);
    bit = marca(k);
    [U,S,V] = svd(A);
    S(3,3) = S(2,2);
    S(2,2) = S(2,2)+alpha*bit;
    if(S(1,1) < S(2,2))
      S(1,1) = S(2,2);
    end
    Amod = U*S*(V');
    watermarked_image_dbl(i:i+3,j:j+3) = Amod;
    k = k+1;
  end
end

% se convierte la imagen marcada a tipo uint8
watermarked_image_int = uint8(watermarked_image_dbl);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'svdIntercambio_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image_dbl,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
