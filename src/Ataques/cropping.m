%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: cropping.m                              |%
%|  Función:  recortado de una imagen.                     |%
%|  Parámetros entrada:                                    |%
%|    - I: imagen a tratar.                                |%
%|    - XMIN: coordenada x.                                |%
%|    - YMIN: coordenada y.                                |%
%|    - WIDTH: ancho que se desea.                         |%
%|    - HEIGHT: alto que se desea.                         |%
%|  Parámetros salida:                                     |%
%|    - I: imagen con el recortado realizado.              |%
%-----------------------------------------------------------%

function [] = cropping(I,XMIN,YMIN,WIDTH,HEIGHT,file_name)
  I = imcrop(I, [XMIN YMIN WIDTH HEIGHT]);
  cd 'ImagenesAtaques'
  imwrite(I,file_name);
  cd ..
return
