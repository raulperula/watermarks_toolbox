%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: noise.m                                 |%
%|  Función:  añade ruido gausiano a una imagen.           |%
%|  Parámetros entrada:                                    |%
%|    - I:  imagen a tratar.                               |%
%|    - M:  media especificada.                            |%
%|    - V:  varianza especificada.                         |%
%|  Parámetros salida:                                     |%
%|    - I: imagen con el ruido gaussiano añadido.          |%
%-----------------------------------------------------------%

function [] = noise(I,file_name,M,V)
  if(nargin == 2)
    % se añade ruido gaussiano con media cero y varianza 0.01
    I = imnoise(I,'gaussian');
    cd 'ImagenesAtaques'
    imwrite(I,file_name);
    cd ..
  else
    % se añade ruido gaussiano con media y varianza especificados
    I = imnoise(I,'gaussian',M,V);
  end
return
