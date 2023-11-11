/*
TODO: 🔧 Extension DB LINK 🔧
    -> Es la manera mas comun de conectar un bd local con una remota , y interactuar entre si .
*/

-- Instalar la extension , en caso no sea de tu autoria la db debes verificar los permisos que tienes
CREATE EXTENSION dblink; 

-- Abre una conexión a la base de datos remota
SELECT dblink_connect('remote_db_connection', 'host=192.168.1.100 dbname=remote_db user=usuario password=contrasena');

-- Cierra la conexión a la base de datos remota
SELECT dblink_disconnect('remote_db_connection');


--*=================================================================
--* EJEMPLO COMPLEJO PARA PONERLO EN PRUEBA


-- ? TABLAS DE LA BD REMOTA 

CREATE TABLE productos (
    id serial PRIMARY KEY,
    nombre VARCHAR(100),
    precio NUMERIC,
    stock INT
);

-- (para registrar ventas en la base de datos remota):
CREATE TABLE ventas_remotas (
    id serial PRIMARY KEY,
    producto_id INT,
    cantidad INT,
    fecha_venta DATE
);


-- ? TABLAS BD LOCAL 

CREATE TABLE productos_locales (
    id serial PRIMARY KEY,
    nombre VARCHAR(100),
    precio NUMERIC
);

CREATE TABLE ventas_locales (
    id serial PRIMARY KEY,
    producto_id INT,
    cantidad INT,
    fecha_venta DATE
);


-- * A continuación, crearemos un trigger en "local_db" que, cuando se inserta una nueva venta en "ventas_locales", registra la venta en "ventas_remotas" en la base de datos remota y actualiza el stock del producto en la base de datos remota. 


-- Abre una conexión a la base de datos remota
SELECT dblink_connect('remote_db_connection', 'host=192.168.1.100 dbname=remote_db user=usuario password=contrasena');

-- Trigger en local_db para registrar ventas en la base de datos remota
CREATE OR REPLACE FUNCTION registrar_venta_en_remota()
RETURNS TRIGGER AS $$
DECLARE
    stock_actual INT;
BEGIN
    -- Registra la venta en ventas_remotas en la base de datos remota
    INSERT INTO dblink('remote_db_connection', 'INSERT INTO ventas_remotas (producto_id, cantidad, fecha_venta) VALUES (' || NEW.producto_id || ', ' || NEW.cantidad || ', current_date)');

    -- Obtiene el stock actual del producto en la base de datos remota
    SELECT stock INTO stock_actual
    FROM dblink('remote_db_connection', 'SELECT stock FROM productos WHERE id = ' || NEW.producto_id) AS remote_data(stock INT);

    -- Actualiza el stock en la base de datos remota
    EXECUTE 'UPDATE productos SET stock = ' || stock_actual - NEW.cantidad || ' WHERE id = ' || NEW.producto_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER registrar_venta_trigger
AFTER INSERT ON ventas_locales
FOR EACH ROW
EXECUTE FUNCTION registrar_venta_en_remota();

-- Cierra la conexión a la base de datos remota
SELECT dblink_disconnect('remote_db_connection');
