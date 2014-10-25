%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: scdct_insertar.m                        |%
%|  Función:  inserción de una marca de agua por el método |%
%|            de las secuencias caoticas y DCT.            |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
tam = 1000;
alpha = 0.3;
key = 250.;

% se guardan las variables que harán falta para la extracción
cd 'Datos'
save 'datosSCDCT.mat' tam key;
cd ..

% se lee la imagen de cobertura
file_name = 'lena_256.bmp';
cover_object = double(imread(file_name));

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

ma = [1 1; 2 3];      % matriz inicial
K = [115 84;168 27];  % matriz para realizar la permutación directamente

% se realizan las 42 iteraciones de Arnold
permutada = zeros(Mc,Nc);
for i = 1:Mc
  for j = 1:Nc
    ic = i-1;
    jc = j-1;
    nuevos = mod(K*[ic;jc],Mc);
    permutada(nuevos(1)+1,nuevos(2)+1) = cover_object(i,j);
  end
end

% se calcula la DCT
trans = dct2(permutada);

% se genera la marca con numeros pseudoaleatorios de una N(0,1)
randn('state',key);
marca = randn(tam,1);

% se ponen los coeficientes en zig-zag
transmod = trans;
k = 1;
for i = 2:Mc
  for j = 1:i
    if(k <= tam)
      transmod(i,j) = trans(i,j)+alpha*marca(k)*abs(trans(i,j));
      k = k+1;
    end
  end
end

%se realiza la transformada inversa
inversa = idct2(transmod);

% se deshace la permutación
K = [27 172;88 115];  % matriz para deshacer la permutación directamente
watermarked_image_dbl = zeros(Mc,Nc);
for i = 1:Mc
  for j = 1:Nc
    ic = i-1;
    jc = j-1;
    nuevos = mod(K*[ic;jc],Mc);
    watermarked_image_dbl(nuevos(1)+1,nuevos(2)+1) = inversa(i,j);
  end
end

% se convierte la imagen marcada a tipo uint8
watermarked_image_int = uint8(watermarked_image_dbl);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'scdct_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image_dbl,Mc,Nc)

% se muestra la imagen marcada por pantalla
% figure
% imshow(watermarked_image_int,[])
% title('Imagen Marcada')
