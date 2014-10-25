%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: scaled.m                                |%
%|  Función:  escalado de una imagen.                      |%
%|  Parámetros entrada:                                    |%
%|    - I:  imagen a tratar.                               |%
%|    - scale:  tamaño de escalado.                        |%
%|  Parámetros salida:                                     |%
%|    - I: imagen con el escalado realizado.               |%
%-----------------------------------------------------------%

function [] = scaled(I,scale,file_name)
  I = imresize(I, scale);
  cd 'ImagenesAtaques'
  imwrite(I,file_name);
  cd ..
return
