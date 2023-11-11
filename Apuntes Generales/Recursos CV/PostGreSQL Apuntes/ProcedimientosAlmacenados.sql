/*
TODO: 👀 Procedimientos Almacenados (PL/pgSQL) 📚
    -> Son funciones para el manejo de la BD
    -> Para crearla click derecho en el apartado del apartado Functions dentro de la tabla en PG Admin
*/

-- Crear / ACTUALIZAR  un procedimiento almacenado en PostgreSQL 
CREATE OR REPLACE FUNCTION importantePL() 
    RETURNS INTEGER --> Definimos el tipo de dato del valor que retornaremos , en caso sea nada se coloca void

AS $$ --> Marca el inicio de la funcion
DECLARE --> Declaracion de variables 
    rec record;
    contador integer := 0
BEGIN
    FOR rec SELECT * FROM pasajero LOOP
    RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
    contador := contador + 1;

    END LOOP;
    RAISE NOTICE 'Conteo es %' , contador;
    RETURN CONTADOR
END 
$$ LANGUAGE plpgsql;


-- LLamado de la funcion
SELECT importantePL();

-- Borrar funcion en caso cambiemos tipos de valores o el return 

DROP FUNCTION importantePL();

--* ==============================================================

CREATE TABLE clientes (
  cliente_id SERIAL PRIMARY KEY,
  nombre VARCHAR(100)
);


+------------+-----------+
| cliente_id | nombre    |
+------------+-----------+
| 1          | Juan      |
| 2          | María     |
| 3          | Pedro     |
+------------+-----------+


CREATE TABLE pedidos (
  pedido_id SERIAL PRIMARY KEY,
  cliente_id INT,
  producto VARCHAR(100),
  cantidad INT
  precio NUMERIC
);

+-----------+------------+------------+---------+--------+
| pedido_id | cliente_id | producto   | cantidad | precio |
+-----------+------------+------------+---------+--------+
| 1         | 1          | Producto A | 5       | 10.00  |
| 2         | 2          | Producto B | 3       | 8.50   |
| 3         | 1          | Producto C | 2       | 12.00  |
| 4         | 3          | Producto A | 4       | 10.00  |
+-----------+------------+------------+---------+--------+


-- Crear un procedimiento almacenado para gestionar pedidos y calcular el total gastado
CREATE OR REPLACE FUNCTION gestionar_pedido(
  nombre_cliente VARCHAR(100),
  producto_pedido VARCHAR(100),
  cantidad_pedido INT
) RETURNS NUMERIC AS $$
DECLARE
  cliente_id INT; --> Variable creada 
  total_gastado NUMERIC;
BEGIN
  -- Obtener el ID del cliente y almacenarlo con INTO en la variable que se creo en DECLARE
  SELECT cliente_id INTO cliente_id FROM clientes WHERE nombre = nombre_cliente;
  
  -- Agregar un nuevo pedido
  INSERT INTO pedidos (cliente_id, producto, cantidad) VALUES (cliente_id, producto_pedido, cantidad_pedido);
  
  -- Calcular el total gastado por el cliente
  SELECT SUM(p.producto_total) INTO total_gastado
  FROM (
    SELECT cantidad * precio AS producto_total
    FROM pedidos
    JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
    WHERE clientes.cliente_id = cliente_id
  ) AS p;
  
  -- Devolver el total gastado
  RETURN total_gastado;
END;
$$ LANGUAGE plpgsql;

--* ==============================================================