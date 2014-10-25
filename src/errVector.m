%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: errVector.m                             |%
%|  Función:  comprueba cuantos bits son erróneos entre la |%
%|            marca original y la extraida.                |%
%|  Parámetros entrada:                                    |%
%|    - orig_watermark:  marca original.                   |%
%|    - watermark:  marca extraida.                        |%
%|    - tam: dimensión de la marca.                        |%
%|  Parámetros salida:                                     |%
%|    - Ninguno.                                           |%
%-----------------------------------------------------------%

function errVector(orig_watermark,watermark,tam)
  malos = 0;
  
  for i = 1:tam
    if(orig_watermark(i) ~= watermark(i))
      malos = malos+1;
    end
  end

    fprintf('Bits mal recuperados de la marca: %d de %d\n',malos,tam);
end
