%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: simAtaques.m                            |%
%|  Función:  realiza la simulación de todos los ataques   |%
%|      posibles a todos los algoritmos estudiados.        |%
%-----------------------------------------------------------%

% Ataques sobre algoritmo de técnicas basadas en correlación
cd 'ImagenesPruebas'
I = imread('cor_watermarked.bmp');
cd ..

JPEG(I,'cor_JPEGatack.jpg',60);
noise(I,'cor_NOISEatack.bmp');
meanFilter(I,'cor_MEANatack.bmp');
cropping(I,75,68,300,300,'cor_CROPPINGatack.bmp');
scaled(I,2,'cor_SCALEDatack.bmp');
rotate(I,90,'cor_ROTATEatack.bmp');

% Ataques sobre algoritmo de Cox
cd 'ImagenesPruebas'
I = imread('cox_watermarked.bmp');
cd ..

JPEG(I,'cox_JPEGatack.jpg',60);
noise(I,'cox_NOISEatack.bmp');
meanFilter(I,'cox_MEANatack.bmp');
cropping(I,75,68,300,300,'cox_CROPPINGatack.bmp');
scaled(I,2,'cox_SCALEDatack.bmp');
rotate(I,90,'cox_ROTATEatack.bmp');

% Ataques sobre algoritmo DCT
cd 'ImagenesPruebas'
I = imread('dct_watermarked.bmp');
cd ..

JPEG(I,'dct_JPEGatack.jpg',60);
noise(I,'dct_NOISEatack.bmp');
meanFilter(I,'dct_MEANatack.bmp');
cropping(I,75,68,300,300,'dct_CROPPINGatack.bmp');
scaled(I,2,'dct_SCALEDatack.bmp');
rotate(I,90,'dct_ROTATEatack.bmp');

% Ataques sobre algoritmo DCTCorrelacion
cd 'ImagenesPruebas'
I = imread('dctcor_watermarked.bmp');
cd ..

JPEG(I,'dctcor_JPEGatack.jpg',60);
noise(I,'dctcor_NOISEatack.bmp');
meanFilter(I,'dctcor_MEANatack.bmp');
cropping(I,75,68,300,300,'dctcor_CROPPINGatack.bmp');
scaled(I,2,'dctcor_SCALEDatack.bmp');
rotate(I,90,'dctcor_ROTATEatack.bmp');

% Ataques sobre algoritmo CDMA
cd 'ImagenesPruebas'
I = imread('cdma_watermarked.bmp');
cd ..

JPEG(I,'cdma_JPEGatack.jpg',60);
noise(I,'cdma_NOISEatack.bmp');
meanFilter(I,'cdma_MEANatack.bmp');
cropping(I,75,68,300,300,'cdma_CROPPINGatack.bmp');
scaled(I,2,'cdma_SCALEDatack.bmp');
rotate(I,90,'cdma_ROTATEatack.bmp');

% Ataques sobre algoritmo DWT
cd 'ImagenesPruebas'
I = imread('dwt_watermarked.bmp');
cd ..

JPEG(I,'dwt_JPEGatack.jpg',60);
noise(I,'dwt_NOISEatack.bmp');
meanFilter(I,'dwt_MEANatack.bmp');
cropping(I,75,68,300,300,'dwt_CROPPINGatack.bmp');
scaled(I,2,'dwt_SCALEDatack.bmp');
rotate(I,90,'dwt_ROTATEatack.bmp');

% Ataques sobre algoritmo DWTHaar
cd 'ImagenesPruebas'
I = imread('dwtHaar_watermarked.bmp');
cd ..

JPEG(I,'dwtHaar_JPEGatack.jpg',60);
noise(I,'dwtHaar_NOISEatack.bmp');
meanFilter(I,'dwtHaar_MEANatack.bmp');
cropping(I,75,68,300,300,'dwtHaar_CROPPINGatack.bmp');
scaled(I,2,'dwtHaar_SCALEDatack.bmp');
rotate(I,90,'dwtHaar_ROTATEatack.bmp');

% Ataques sobre algoritmo DWTParidad
cd 'ImagenesPruebas'
I = imread('dwtParidad_watermarkedMod.bmp');
cd ..

JPEG(I,'dwtParidad_JPEGatack.jpg',60);
noise(I,'dwtParidad_NOISEatack.bmp');
meanFilter(I,'dwtParidad_MEANatack.bmp');
cropping(I,75,68,300,300,'dwtParidad_CROPPINGatack.bmp');
scaled(I,2,'dwtParidad_SCALEDatack.bmp');
rotate(I,90,'dwtParidad_ROTATEatack.bmp');

% Ataques sobre algoritmo SVD
cd 'ImagenesPruebas'
I = imread('svd_watermarked.bmp');
cd ..

JPEG(I,'svd_JPEGatack.jpg',60);
noise(I,'svd_NOISEatack.bmp');
meanFilter(I,'svd_MEANatack.bmp');
cropping(I,75,68,300,300,'svd_CROPPINGatack.bmp');
scaled(I,2,'svd_SCALEDatack.bmp');
rotate(I,90,'svd_ROTATEatack.bmp');

% Ataques sobre algoritmo SVDArnold
cd 'ImagenesPruebas'
I = imread('svdArnold_watermarked.bmp');
cd ..

JPEG(I,'svdArnold_JPEGatack.jpg',60);
noise(I,'svdArnold_NOISEatack.bmp');
meanFilter(I,'svdArnold_MEANatack.bmp');
cropping(I,75,68,300,300,'svdArnold_CROPPINGatack.bmp');
scaled(I,2,'svdArnold_SCALEDatack.bmp');
rotate(I,90,'svdArnold_ROTATEatack.bmp');

% Ataques sobre algoritmo SVDIntercambio
cd 'ImagenesPruebas'
I = imread('svdIntercambio_watermarked.bmp');
cd ..

JPEG(I,'svdIntercambio_JPEGatack.jpg',60);
noise(I,'svdIntercambio_NOISEatack.bmp');
meanFilter(I,'svdIntercambio_MEANatack.bmp');
cropping(I,75,68,300,300,'svdIntercambio_CROPPINGatack.bmp');
scaled(I,2,'svdIntercambio_SCALEDatack.bmp');
rotate(I,90,'svdIntercambio_ROTATEatack.bmp');

% Ataques sobre algoritmo SVDOrden
cd 'ImagenesPruebas'
I = imread('svdOrden_watermarked.bmp');
cd ..

JPEG(I,'svdOrden_JPEGatack.jpg',60);
noise(I,'svdOrden_NOISEatack.bmp');
meanFilter(I,'svdOrden_MEANatack.bmp');
cropping(I,75,68,300,300,'svdOrden_CROPPINGatack.bmp');
scaled(I,2,'svdOrden_SCALEDatack.bmp');
rotate(I,90,'svdOrden_ROTATEatack.bmp');

% Ataques sobre algoritmo SVDProximidad
cd 'ImagenesPruebas'
I = imread('svdProximidad_watermarked.bmp');
cd ..

JPEG(I,'svdProximidad_JPEGatack.jpg',60);
noise(I,'svdProximidad_NOISEatack.bmp');
meanFilter(I,'svdProximidad_MEANatack.bmp');
cropping(I,75,68,300,300,'svdProximidad_CROPPINGatack.bmp');
scaled(I,2,'svdProximidad_SCALEDatack.bmp');
rotate(I,90,'svdProximidad_ROTATEatack.bmp');

% Ataques sobre algoritmo LSB
cd 'ImagenesPruebas'
I = imread('lsb_watermarked.bmp');
cd ..

JPEG(I,'lsb_JPEGatack.jpg',60);
noise(I,'lsb_NOISEatack.bmp');
meanFilter(I,'lsb_MEANatack.bmp');
cropping(I,75,68,300,300,'lsb_CROPPINGatack.bmp');
scaled(I,2,'lsb_SCALEDatack.bmp');
rotate(I,90,'lsb_ROTATEatack.bmp');

% Ataques sobre algoritmo SC
cd 'ImagenesPruebas'
I = imread('sc_watermarked.bmp');
cd ..

JPEG(I,'sc_JPEGatack.jpg',60);
noise(I,'sc_NOISEatack.bmp');
meanFilter(I,'sc_MEANatack.bmp');
cropping(I,75,68,300,300,'sc_CROPPINGatack.bmp');
scaled(I,2,'sc_SCALEDatack.bmp');
rotate(I,90,'sc_ROTATEatack.bmp');

% Ataques sobre algoritmo SCDCT
cd 'ImagenesPruebas'
I = imread('scdct_watermarked.bmp');
cd ..

JPEG(I,'scdct_JPEGatack.jpg',60);
noise(I,'scdct_NOISEatack.bmp');
meanFilter(I,'scdct_MEANatack.bmp');
cropping(I,75,68,300,300,'scdct_CROPPINGatack.bmp');
scaled(I,2,'scdct_SCALEDatack.bmp');
rotate(I,90,'scdct_ROTATEatack.bmp');

% Ataques sobre algoritmo PCA
cd 'ImagenesPruebas'
I = imread('pca_watermarked.bmp');
cd ..

JPEG(I,'pca_JPEGatack.jpg',60);
noise(I,'pca_NOISEatack.bmp');
meanFilter(I,'pca_MEANatack.bmp');
cropping(I,75,68,300,300,'pca_CROPPINGatack.bmp');
scaled(I,2,'pca_SCALEDatack.bmp');
rotate(I,90,'pca_ROTATEatack.bmp');

% Ataques sobre algoritmo PCAReferencia
cd 'ImagenesPruebas'
I = imread('pcaReferencia_watermarked.bmp');
cd ..

JPEG(I,'pcaReferencia_JPEGatack.jpg',60);
noise(I,'pcaReferencia_NOISEatack.bmp');
meanFilter(I,'pcaReferencia_MEANatack.bmp');
cropping(I,75,68,300,300,'pcaReferencia_CROPPINGatack.bmp');
scaled(I,2,'pcaReferencia_SCALEDatack.bmp');
rotate(I,90,'pcaReferencia_ROTATEatack.bmp');
