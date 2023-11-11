/*
TODO: 🔧 Procedimientos Almacenados (PL/pgSQL) 🔧
    -> Un trigger es una función especial que se ejecuta automáticamente antes o después de realizar una acción en una tabla, como la inserción (INSERT), actualización (UPDATE) o eliminación (DELETE) de registros. 

    -> puedes encontrarla en pg adming como "trigger functions" dentro del apartado de TABLAS (dentro de cada tabla tambien tienes un apartado de trigger para que coloques uno que fue creado)
*/


CREATE TABLE clientes (
    id serial PRIMARY KEY,
    nombre VARCHAR(50),
    total_gastado NUMERIC
);


CREATE TABLE historial_compras (
    id serial PRIMARY KEY,
    cliente_id INT,
    monto_compra NUMERIC
);

/*
    Cuando se inserta una nueva compra en la tabla historial_compras, el trigger se activa, suma el monto de la compra al total_gastado del cliente correspondiente en la tabla clientes, y actualiza automáticamente ese valor.
*/

CREATE OR REPLACE FUNCTION actualizar_total_gastado()
RETURNS TRIGGER AS $$
BEGIN
    -- Obtenemos el ID del cliente que realizó la compra
    -- y el monto de la compra
    DECLARE
        cliente_id INT;
        monto NUMERIC;
    BEGIN
        cliente_id := NEW.cliente_id;
        monto := NEW.monto_compra;
        
        -- Actualizamos el campo total_gastado en la tabla clientes
        UPDATE clientes
        SET total_gastado = total_gastado + monto
        WHERE id = cliente_id;
        
        RETURN NEW;
    END;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualiza_total_gastado_trigger
AFTER INSERT ON historial_compras
FOR EACH ROW
EXECUTE FUNCTION actualizar_total_gastado();


/*
*================================================================
*/

CREATE TABLE clientes (
    id serial PRIMARY KEY,
    nombre VARCHAR(50),
    total_gastado NUMERIC,
    promedio_compra NUMERIC
);

CREATE TABLE historial_compras (
    id serial PRIMARY KEY,
    cliente_id INT,
    monto_compra NUMERIC
);


/*
En este ejemplo:

Hemos creado dos tablas: clientes y historial_compras, similares al ejemplo anterior.

    ->El trigger actualiza_promedio_compra_trigger se ejecuta automáticamente después de cada inserción en la tabla historial_compras.

    -> La función actualizar_promedio_compra() utiliza un bucle FOR IN para recorrer todas las compras de un cliente y calcular la suma total de montos y la cantidad de compras.

    -> Luego, se calcula el promedio y se actualiza el campo promedio_compra en la tabla clientes para el cliente correspondiente.

    -> Con este trigger, el campo promedio_compra en la tabla clientes se mantiene actualizado con el promedio de las compras de cada cliente a medida que se insertan nuevas compras en la tabla historial_compras.

*/

CREATE OR REPLACE FUNCTION actualizar_promedio_compra()
RETURNS TRIGGER AS $$
DECLARE
    total_monto NUMERIC := 0;
    cantidad_compras INT := 0;
BEGIN
    -- Recorremos todas las compras del cliente y calculamos la suma total
    FOR compra_rec IN (SELECT monto_compra FROM historial_compras WHERE cliente_id = NEW.cliente_id) 
    LOOP
        total_monto := total_monto + compra_rec.monto_compra;
        cantidad_compras := cantidad_compras + 1;
    END LOOP;
    
    -- Calculamos el promedio
    IF cantidad_compras > 0 THEN
        NEW.promedio_compra := total_monto / cantidad_compras;
    ELSE
        NEW.promedio_compra := 0;
    END IF;
    
    -- Actualizamos el campo promedio_compra en la tabla clientes
    UPDATE clientes
    SET promedio_compra = NEW.promedio_compra
    WHERE id = NEW.cliente_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualiza_promedio_compra_trigger
AFTER INSERT ON historial_compras
FOR EACH ROW
EXECUTE FUNCTION actualizar_promedio_compra();

