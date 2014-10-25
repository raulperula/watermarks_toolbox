%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: meanFilter.m                            |%
%|  Función:  aplica un filtro de paso bajo a una imagen.  |%
%|  Parámetros entrada:                                    |%
%|    - I:  imagen a tratar.                               |%
%|  Parámetros salida:                                     |%
%|    - I: imagen con el filtro de paso bajo aplicado.     |%
%-----------------------------------------------------------%

function [] = meanFilter(I,file_name)
  % se crea el filtro de la media
  h = fspecial('average',8);
  % se aplica el filtro
  I = imfilter(I,h);
  cd 'ImagenesAtaques'
  imwrite(I,file_name);
  cd ..
return
