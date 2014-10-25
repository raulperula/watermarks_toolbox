%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: dwtParidad_insertar.m                   |%
%|  Función:  inserción de una marca de agua por el método |%
%|            DWT basado en la paridad.                    |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
constante = 20;
tam = 128;
key = 250.;

% se guardan los datos que harán falta para la extracción
cd 'Datos'
save datosDWTParidad.mat constante tam key;
cd ..

% se lee la imagen de cobertura
file_name = 'lena_512.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se crea la marca de agua que será una matriz de 128 bits pseudoaleatorios
rand('state',key); 
marca = ceil(2*rand(tam*tam,1)-1);

% se realiza la DWT bidimensional en dos niveles
[cA1,cH1,cV1,cD1] = dwt2(cover_object,'haar');
[cA2,cH2,cV2,cD2] = dwt2(cA1,'haar');

coefmod = cA2;
k = 1;
for i = 1:tam
  for j = 1:tam
    bit = marca(k);
    k = k+1;
    coef = floor(cA2(i,j)/constante);
    if(bit ~= mod(coef,2))
      coefmod(i,j) = (coef+1)*constante;
    end
  end
end

% se reconstruye la imagen marcada
X2 = idwt2(coefmod,cH2,cV2,cD2,'haar');
watermarked_image_dbl = idwt2(X2,cH1,cV1,cD1,'haar');
watermarked_image_int = uint8(watermarked_image_dbl);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'dwtParidad_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image_dbl,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
