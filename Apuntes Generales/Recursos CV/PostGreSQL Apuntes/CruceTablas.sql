/*

Supongamos que tenemos dos tablas: clientes y pedidos. La tabla clientes contiene información sobre los clientes, y la tabla pedidos contiene información sobre los pedidos que los clientes han realizado.

TODO: TABLA "clientes"
*/

| cliente_id | nombre     |
|------------|------------|
| 1          | Cliente A  |
| 2          | Cliente B  |
| 3          | Cliente C  |

/*
TODO: TABLA "pedidos"
*/
| pedido_id  | cliente_id | producto   |
|------------|------------|------------|
| 101        | 1          | Producto X |
| 102        | 2          | Producto Y |
| 103        | 1          | Producto Z |
| 104        | 3          | Producto X |

/*
? INNER JOIN:
    -> También se le llama simplemente "JOIN".
    
    -> Devuelve solo las filas que tienen valores coincidentes en ambas tablas.

    -> Las filas que no tienen una coincidencia en ambas tablas se excluyen del resultado.

    En este ejemplo, estamos obteniendo el nombre del cliente y el producto de los pedidos que han realizado. El INNER JOIN asegura que solo obtengamos resultados cuando haya una coincidencia entre cliente_id en ambas tablas.
*/
    SELECT clientes.nombre, pedidos.producto
    FROM clientes
    INNER JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

/*
* Resultado
*/

    | nombre     | producto   |
    |------------|------------|
    | Cliente A  | Producto X |
    | Cliente A  | Producto Z |
    | Cliente B  | Producto Y |
    | Cliente C  | Producto X |


/*
? LEFT JOIN (o LEFT OUTER JOIN):
    -> Devuelve todas las filas de la tabla izquierda (clientes) y las filas coincidentes de la tabla derecha (pedidos).

    -> Si no hay una coincidencia en la tabla derecha, se devuelven NULL en las columnas de la tabla derecha.

    Aquí, obtenemos todos los clientes, incluso aquellos que no han realizado pedidos. Si un cliente no ha realizado pedidos, la columna producto en la tabla de pedidos mostrará NULL.
*/
    SELECT clientes.nombre, pedidos.producto
    FROM clientes
    LEFT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

/*
* Resultado
*/
    | nombre     | producto   |
    |------------|------------|
    | Cliente A  | NULL       |
    | Cliente A  | Producto Z |
    | Cliente B  | Producto Y |
    | Cliente C  | Producto X |


/*
? RIGHT JOIN (o RIGHT OUTER JOIN):
    -> Similar al LEFT JOIN, pero devuelve todas las filas de la tabla derecha (pedidos) y las filas coincidentes de la tabla izquierda (clientes).

    -> Si no hay una coincidencia en la tabla izquierda, se devuelven NULL en las columnas de la tabla izquierda.

    En este caso, obtendremos todos los pedidos, incluso aquellos que no están asociados a un cliente en la tabla de clientes. Si no hay una coincidencia, la columna nombre mostrará NULL.
*/
    SELECT clientes.nombre, pedidos.producto
    FROM clientes
    RIGHT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

/*
* Resultado
*/

    | nombre     | producto   |
    |------------|------------|
    | Cliente A  | Producto X |
    | Cliente A  | Producto Z |
    | Cliente B  | Producto Y |
    | Cliente C  | Producto X |


/*
? FULL OUTER JOIN:
    -> Devuelve todas las filas cuando hay una coincidencia en cualquiera de las dos tablas (clientes o pedidos).

    -> Si no hay una coincidencia en una tabla, se devuelven NULL en las columnas de esa tabla.

    En este ejemplo, obtendremos todos los clientes y todos los pedidos. Si un cliente no ha realizado pedidos o si un pedido no está asociado a un cliente, las columnas respectivas mostrarán NULL.
*/
    SELECT clientes.nombre, pedidos.producto
    FROM clientes
    FULL JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

/*
* Resultado
*/

    | nombre     | producto   |
    |------------|------------|
    | Cliente A  | Producto X |
    | Cliente A  | Producto Z |
    | Cliente B  | Producto Y |
    | Cliente C  | Producto X |
    | NULL       | Producto W |




/*
? CROSS JOIN:
    -> Realiza un producto cartesiano entre las dos tablas, es decir, combina cada fila de la primera tabla con cada fila de la segunda tabla.

    -> No utiliza una condición de coincidencia.

    -> Puede generar un gran número de resultados y no es comúnmente utilizado en situaciones prácticas, a menos que sea necesario.

    Esto generaría todas las posibles combinaciones de clientes y pedidos, lo cual puede ser útil en casos muy específicos, pero en la mayoría de los casos no es deseable debido a la gran cantidad de resultados que puede generar.
*/

    SELECT clientes.nombre, pedidos.producto
    FROM clientes
    CROSS JOIN pedidos;

/*
* Resultado
*/  
| nombre     | producto   |
|------------|------------|
| Cliente A  | Producto X |
| Cliente A  | Producto Y |
| Cliente A  | Producto Z |
| Cliente A  | Producto W |
| Cliente B  | Producto X |
| Cliente B  | Producto Y |
| Cliente B  | Producto Z |
| Cliente B  | Producto W |
| Cliente C  | Producto X |
| Cliente C  | Producto Y |
| Cliente C  | Producto Z |
| Cliente C  | Producto W |


