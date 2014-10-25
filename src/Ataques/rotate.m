%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: rotate.m                                |%
%|  Función:  rotación de una imagen en el plano.          |%
%|  Parámetros entrada:                                    |%
%|    - I:  imagen a tratar.                               |%
%|    - angle:  ángulo en grados.                          |%
%|  Parámetros salida:                                     |%
%|    - I: imagen rotada.                                  |%
%-----------------------------------------------------------%

function [] = rotate(I,angle,file_name)
  I = imrotate(I,angle,'crop');
  cd 'ImagenesAtaques'
  imwrite(I,file_name);
  cd ..
return
