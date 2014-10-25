%-----------------------------------------------------------%
%|  Nombre proyecto:  Marcas de agua en imágenes digitales |%
%|  Autor:            Raúl Pérula Martínez                 |%
%|  Año:              2009                                 |%
%-----------------------------------------------------------%
%|  Nombre código: correlacion.m                           |%
%|  Función:  calcula la correlación entre dos marcas de   |%
%|            agua.                                        |%
%|  Parámetros entrada:                                    |%
%|    - orig_watermark:  marca original.                   |%
%|    - watermark:  marca extraida.                        |%
%|    - tam: número de filas de la marca.                  |%
%|    - tam1: número de columnas de la marca.              |%
%|  Parámetros salida:                                     |%
%|    - grafico: grafica de correlaciones.                 |%
%-----------------------------------------------------------%

function grafico = correlacion(orig_watermark,watermark,tam,tam1)
  % se inicializa a ceros el vector
  correlacion = zeros(1,500);
  
  if nargin == 3
    % se crean las marcas aleatorias
    for i = 1:500
      randn('state',double(i));
      ale_watermark = randn(tam,tam);
      correlacion(i) = corr2(watermark,ale_watermark);
    end
  else
    % se crean las marcas aleatorias
    for i = 1:500
      randn('state',double(i));
      ale_watermark = randn(tam,tam1);
      correlacion(i) = corr2(watermark,ale_watermark);
    end
  end
  
  % se pone el resultado con la marca original y la extraida
  correlacion(250) = corr2(orig_watermark,watermark);

  % se crea el gráfico con los 500 resultados
  x = 1:500;
  grafico = plot(x,correlacion);
end