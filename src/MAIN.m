
% Apertura de los ficheros
file_psnr = fopen('psnr.txt','at+');
file_time = fopen('time.txt','at+');

% Algoritmo de Correlacion
cor_insertar
  fprintf(file_time, '%s\n\n','Algoritmo de Correlacion');
  fprintf(file_time, ' %s\n','Tiempo insercion');
  fprintf(file_time, ' %d\n\n',elapsed_time);

  fprintf(file_psnr, ' %s\n','PSNR');
  fprintf(file_psnr, ' %d\n\n',psnr);

cor_recuperar
  fprintf(file_time, ' %s\n','Tiempo recuperacion');
  fprintf(file_time, ' %d\n\n',elapsed_time);

cor_recuperarmod
  fprintf(file_time, ' %s\n','Tiempo recuperacion del modificado');
  fprintf(file_time, ' %d\n\n',elapsed_time);

%{
Algoritmo de Cox
cox_insertar
cox_recuperar

% Algoritmo DCT
dct_insertar
dct_recuperar

% Algoritmo DCT Correlacion
dctcor_insertar
dctcor_recuperar

% Algoritmo CDMA
cdma_insertar
cdma_recuperar

% Algoritmo DWT
dwt_insertar
dwt_recuperar

% Algoritmo DWT Haar
dwtHaar_insertar
dwtHaar_recuperar

% Algoritmo DWT Paridad
dwtParidad_insertar
dwtParidad_recuperar
dwtParidad_insertarmod
dwtParidad_recuperar

% Algoritmo SVD
svd_insertar
svd_recuperar

% Algoritmo SVD Arnold
svdArnold_insertar
svdArnold_recuperar

% Algoritmo SVD Intercambio
svdIntercambio_insertar
svdIntercambio_recuperar

% Algoritmo SVD Orden
svdOrden_insertar
svdOrden_recuperar

% Algoritmo SVD Proximidad
svdProximidad_insertar
svdProximidad_recuperar

% Algoritmo LSB
lsb_insertar
lsb_recuperar

% Algoritmo SC
sc_insertar
sc_recuperar

% Algoritmo SC y DCT
scdct_insertar
scdct_recuperar
scdct_insertar_sin_permutacion
scdct_recuperar_sin_permutacion

% Algoritmo PCA
pca_insertar
pca_recuperar

% Algoritmo PCA Imagen Referencia
pcaReferencia_insertar
pcaReferencia_recuperar
%}

% Cierre de los ficheros
fclose('all');
