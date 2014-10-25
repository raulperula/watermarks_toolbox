%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: JPEG.m                                  |%
%|  Función:  guarda una imagen con compresión jpeg.       |%
%|  Parámetros entrada:                                    |%
%|    - I:  imagen a tratar.                               |%
%|    - file_name:  nombre del archivo a guardar.          |%
%|    - quality:  calidad de la compresión.                |%
%|  Parámetros salida:                                     |%
%|    - No tiene.                                          |%
%-----------------------------------------------------------%

function [] = JPEG(I,file_name,quality)
  cd 'ImagenesAtaques'
  if(nargin == 2)
    % la compresión se realiza con 75 de calidad
    imwrite(I,file_name);
  else
    % se especifica la calidad que se desea
    imwrite(I,file_name,'Quality',quality);
  end
  cd ..
return
