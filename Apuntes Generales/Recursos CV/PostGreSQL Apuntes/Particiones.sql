/* 
TODO: 📌Particiones📌

        -> Division de una tabla en tablas hijas para gestionar los recursos del equipo y facilitar el acceso atraves de subdivisiones para la busqueda de datos .
*/

/* 
? Por Rangos
    La partición por rango se utiliza para dividir los datos en particiones basadas en un rango de valores de una columna. En este ejemplo, particionaremos una tabla de registros de ventas por rango de fechas.
    
    * En este caso, hemos creado dos tablas hijas, ventas_2022 y ventas_2023, que almacenan datos de ventas para los años 2022 y 2023, respectivamente.
*/
CREATE TABLE ventas (
    venta_id serial PRIMARY KEY,
    fecha_venta date,
    monto numeric
);

CREATE TABLE ventas_2022 PARTITION OF ventas
    FOR VALUES FROM ('2022-01-01') TO ('2022-12-31');

CREATE TABLE ventas_2023 PARTITION OF ventas
    FOR VALUES FROM ('2023-01-01') TO ('2023-12-31');


/* 
? Por Lista
    La partición por lista se utiliza para dividir los datos en particiones basadas en valores específicos de una columna. Aquí, particionaremos una tabla de productos por categoría.

    *En este ejemplo, hemos creado dos tablas hijas, productos_electronicos y productos_ropa, que almacenan productos de las categorías "Electrónica" y "Computadoras", y "Ropa" y "Calzado", respectivamente.
*/

CREATE TABLE productos (
    producto_id serial PRIMARY KEY,
    nombre varchar(100),
    categoria varchar(50)
);

CREATE TABLE productos_electronicos PARTITION OF productos
    FOR VALUES IN ('Electrónica', 'Computadoras');

CREATE TABLE productos_ropa PARTITION OF productos
    FOR VALUES IN ('Ropa', 'Calzado');

/* 
? Por Hash
    La partición por hash se utiliza para dividir los datos en particiones de manera aleatoria, utilizando una función hash. Aquí, particionaremos una tabla de usuarios por hash en función de su ID.
*/

CREATE TABLE usuarios (
    usuario_id serial PRIMARY KEY,
    nombre varchar(100)
);

CREATE TABLE usuarios_particion_1 PARTITION OF usuarios
    FOR VALUES WITH (MODULUS 4, REMAINDER 0);

CREATE TABLE usuarios_particion_2 PARTITION OF usuarios
    FOR VALUES WITH (MODULUS 4, REMAINDER 1);

CREATE TABLE usuarios_particion_3 PARTITION OF usuarios
    FOR VALUES WITH (MODULUS 4, REMAINDER 2);

CREATE TABLE usuarios_particion_4 PARTITION OF usuarios
    FOR VALUES WITH (MODULUS 4, REMAINDER 3);

/* 
?   El MODULUS es 4 (ya que queremos dividir en cuatro particiones).
?   El REMAINDER se calcula para cada fila en función del valor de "usuario_id" y el MODULUS.

En resumen, los 40 registros se distribuirían de la siguiente manera:

"usuarios_particion_1": usuario_id del 1 al 10.
"usuarios_particion_2": usuario_id del 11 al 20.
"usuarios_particion_3": usuario_id del 21 al 30.
"usuarios_particion_4": usuario_id del 31 al 40.
*/
