%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: similaridad.m                           |%
%|  Función:  calcula la similaridad entre dos marcas de   |%
%|            agua.                                        |%
%|  Parámetros entrada:                                    |%
%|    - orig_watermark:  marca original.                   |%
%|    - watermark:  marca extraida.                        |%
%|    - tam: número de filas de la marca.                  |%
%|    - tam1: número de columnas de la marca.              |%
%|  Parámetros salida:                                     |%
%|    - grafico: grafica de similaridades.                 |%
%-----------------------------------------------------------%

function grafico = similaridad(orig_watermark,watermark,tam,tam1)
  if (size(orig_watermark) ~= size(watermark))
    watermark = reshape(watermark,size(orig_watermark));
  end

  % se inicializa a ceros el vector
  simi = zeros(1,500);

  % según el número de parámetros de entrada se crea unas marcas u otras
  if nargin == 3
    % se crean las marcas aleatorias
    for i = 1:500
      rand('seed',double(i));
      ale_watermark = ceil(2*rand(tam,1)-1);
      simi(i) = (ale_watermark'*orig_watermark)/sqrt(ale_watermark'*ale_watermark);
    end
  else
    % se crean las marcas aleatorias
    for i = 1:500
      rand('seed',double(i));
      ale_watermark = ceil(2*rand(tam*tam1,1)-1);
      simi(i) = (ale_watermark'*orig_watermark)/sqrt(ale_watermark'*ale_watermark);
    end
  end
  
  % se pone el resultado con la marca original y la extraida
  simi(250) = (watermark'*orig_watermark)/sqrt(watermark'*watermark);
  
  % se crea el gráfico con los 500 resultados
  x = 1:500;
  grafico = plot(x,simi);
end