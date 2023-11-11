/*

TODO: 👀 Vistas 📚
    -> Es como un type o interface de TypeScript(Molde) ,es comprimir consultas que se usa retiradas veces para evitar escribirlos manualmente
*/

/*
? Vista Volatil
    -> Siempre que se use una vista , esta hara la consulta en la base de datos por lo tanto la informacion que traeras estara actualizada

    -> para crearlas , ingresa a la carpeta Views -> click derecho y create en el apartado code colocas todo lo que quieres comprimir
*/
-- Crear una vista volátil

    CREATE OR REPLACE VIEW vista_ventas AS
    SELECT empleado_id, nombre, salario
    FROM empleados
    WHERE departamento = 'Ventas';

/*
? Vista Materializada - Persistente: 
    -> Haces la consulta 1 vez y esta se almacenara en memoria, vuelves a hacer la misma consulta y en vez de almacenarla ira a la memoria a sacar el resultado que se guardo.

    -> Es util para comparacion con datos pasados , ya que se tienen que actualziar la vista manualmente si quieres datos recientes , por ejemplo comparar los datos de ayer y los de hoy

    -> para crearlas , ingresa a la carpeta Materialized Views -> click derecho y create en el apartado code colocas todo lo que quieres comprimir
*/

    CREATE MATERIALIZED VIEW departamento_empleados AS
    SELECT departamento, COUNT(*) AS cantidad_empleados
    FROM empleados
    GROUP BY departamento;

/*
* Actualizar datos manuales de la vista materializada
*/
    REFRESH MATERIALIZED VIEW departamento_empleados;