%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: cox_insertar.m                          |%
%|  Función:  inserción de una marca de agua por el método |%
%|            de Cox.                                      |%
%-----------------------------------------------------------%

% se limpia todo
clear all;

% se guarda el tiempo de comienzo de computación
start_time = cputime;

% se inicializan los parámetros necesarios
alpha = 0.05;
tam = 2500;
key = 10;

% se guardan las variables que harán falta para la extracción
cd 'Datos'
save 'datosCox.mat' alpha tam key;
cd ..

% se lee la imagen de cobertura
file_name = 'lena_512.bmp';
cover_object = imread(file_name);

% se determinan las dimensiones de la imagen de cobertura
[Mc,Nc] = size(cover_object);

% se realiza la DCT de la imagen de cobertura
dctF1 = dct2(double(cover_object));

% se reinicia el generador PN de MATLAB con "key"
randn('state',key);

% se crea la marca con 'tam' números pseudoaleatorios
W = randn(tam,1);

% se calculan los coeficientes de mayor valor absoluto, se excluye el
% coeficiente DC, es decir, el coeficiente (1,1)
A = dctF1(:);
B = A;
B(1) = 0;

% Y1 contiene los valores ordenados, I1 contiene los índices en que se
% encuentran los valores del vector original
[Y1,I1] = sort(abs(B),'descend');

% se toman los coeficientes sin valor absoluto
Y1 = A(I1);

k = tam;
M = zeros(Mc*Nc,1);
l = 1;
for i = 1:Mc*Nc
  if(k >= 1)
    M(i) = Y1(i)*(1+alpha*W(l));
    l = l+1;
    k = k-1;
  else
    M(i) = Y1(i);
  end
end

% se cogen los valores en el orden de los índices ordenados
N = zeros(Mc*Nc,1);
for i = 1:Mc*Nc
  N(I1(i)) = M(i);
end

% se redimensiona la marca en forma de matriz
dctF2 = reshape(N,[Mc Nc]);

% se aplica la DCT inversa para recuperar la imagen
idctF1 = idct2(dctF2);

% se convierte la marca de agua a tipo uint8
watermarked_image_int = uint8(idctF1);

% se guarda la imagen marcada en un fichero
cd 'ImagenesPruebas'
imwrite(watermarked_image_int,'cox_watermarked.bmp');
cd ..

% se muestra el tiempo de computación
elapsed_time = cputime-start_time

% se calcula el valor del PSNR para la imagen marcada
psnr = psnr(cover_object,watermarked_image_int,Mc,Nc)

% se muestra la imagen marcada
% figure;
% imshow(watermarked_image_int,[]); 
% title('Imagen Marcada'); 
