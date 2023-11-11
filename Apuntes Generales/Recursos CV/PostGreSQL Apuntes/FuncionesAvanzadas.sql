/*
TODO : 🔎 FUNCIONES AVANZADAS 🔍

? COALESCE
    -> Se utiliza para obtener el primer valor no nulo de una lista de expresiones, si una expresion es nula la funcion pasara a la siguiente expresion en la lista (parametros) hasta encontrar alguno que no sea nulo

    Supongamos que tenemos una tabla empleados con las columnas nombre y apellido, y algunos registros tienen valores nulos en la columna apellido. Para obtener un nombre completo que incluya el apellido si está disponible o solo el nombre si el apellido es nulo, puedes usar COALESCE:
*/    
    SELECT COALESCE(apellido1, apellido2 , nombre) AS nombre_completo FROM empleados;
/*
* Tenemos estos datos en la tabla empleados 
*/
| nombre   | apellido1 | apellido2 |
|----------|-----------|-----------|
| Juan     | Smith     | Johnson   |
| Maria    | NULL      | Perez     |
| Carlos   | NULL      | NULL      |
| Laura    | Miller    | NULL      |
/*
* El resultado seria 
*/
| nombre_completo |
|-----------------|
| Smith           |
| Perez           |
| Carlos          |
| Miller          |

/*
? NULLIF
    -> se utiliza para comparar dos expresiones y devolver NULL si son iguales. Si las expresiones son diferentes, devuelve la primera expresión.

    Supongamos que deseas obtener un valor nulo si el campo edad es igual a 0, de lo contrario, obtener el valor real de edad. Puedes usar NULLIF de la siguiente manera:
    
*/
    SELECT NULLIF(edad, 0) AS edad_corregida FROM personas;

/*
* Tenemos estos datos en la tabla empleados 
*/
| edad |
|------|
| 25   |
| 0    |
| 30   |
| 0    |
| 45   |

/*
* El resultado seria 
*/

| edad_corregida |
|----------------|
| 25             |
| NULL           |
| 30             |
| NULL           |
| 45             |

/*


? GREATEST:
    -> se utiliza para obtener el valor más grande de una lista de expresiones.

    Supongamos que tenemos una tabla productos con las columnas precio_original y precio_descuento, y deseamos obtener el precio más alto entre estos dos valores:
*/
    SELECT GREATEST(precio_original, precio_descuento) AS precio_mas_alto FROM productos;

/*
? LEAST
    -> se utiliza para obtener el valor más pequeño de una lista de expresiones.
    
    Supongamos que deseas obtener el precio más bajo entre el precio original y el precio de descuento en una tabla de productos:
*/
    SELECT LEAST(precio_original, precio_descuento) AS precio_mas_bajo FROM productos;

/*
? Bloques Anónimos:
    PostgreSQL no es un sistema de bases de datos que use bloques anónimos como lo haría en Oracle PL/SQL. PostgreSQL utiliza PL/pgSQL para programación almacenada, pero no ofrece una estructura de bloques anónimos como lo hace Oracle PL/SQL. 
    
    En su lugar, puedes crear funciones almacenadas, procedimientos almacenados o incluso disparadores (triggers) para manejar la lógica de programación.
*/    

    CREATE OR REPLACE FUNCTION calcular_promedio(edad1 INT, edad2 INT) RETURNS NUMERIC AS $$
    BEGIN
        RETURN (edad1 + edad2) / 2.0;
    END;
    $$ LANGUAGE plpgsql;

/*
* Puedes llamar a esta función para calcular el promedio de dos edades:
*/

SELECT calcular_promedio(30, 40); -- Devuelve el resultado del promedio
