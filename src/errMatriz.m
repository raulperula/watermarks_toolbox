%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: errMatriz.m                             |%
%|  Función:  comprueba cuantos bits son erróneos entre la |%
%|            marca original y la extraida.                |%
%|  Parámetros entrada:                                    |%
%|    - orig_watermark:  marca original.                   |%
%|    - watermark:  marca extraida.                        |%
%|    - Mw: número de filas de la marca.                   |%
%|    - Nw: número de columnas de la marca.                |%
%|  Parámetros salida:                                     |%
%|    - Ninguno.                                           |%
%-----------------------------------------------------------%

function errMatriz(orig_watermark,watermark,Mw,Nw)
  malos = 0;
  
  for i = 1:Mw
    for j = 1:Nw
      if(orig_watermark(i,j) ~= watermark(i,j))
        malos = malos+1;
      end
    end
  end

  fprintf('Bits mal recuperados de la marca: %d de %d\n',malos,Mw*Nw);
end
