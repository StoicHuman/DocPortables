/*
TODO : 🔎 FUNCIONES ESPECIALES 🔍
    -> Estas funciones de por si son atajos los cuales juntan 2 o mas sentencias SQL para un control mas arapido de elementos

? ON CONFLICT DO
    -> Es el atajo para usar "INSERT" & "UPDATE" , es una clausula para especificar como manejra conflictos , es util cuando intentas insertar o actualizar datos de una tabla y hay una violacion de una restriccion unica

    * Supongamos que tienes una tabla llamada empleados con una restricción única en la columna numero_empleado y deseas insertar un nuevo empleado, pero si ya existe un empleado con el mismo número, deseas actualizar su información.
*/    
    INSERT INTO empleados (numero_empleado, nombre)
    VALUES (123, 'Juan')
    ON CONFLICT (numero_empleado) DO UPDATE
    SET nombre = EXCLUDED.nombre;

/*
! En este ejemplo, si ya existe un empleado con el número 123, se actualizará el nombre del empleado a 'Juan'.
*/

/*
? RETURNING 
    -> Clausula que se usa en las sentencias  "INSERT" , "UPDATE" o "DELETE" para devolver los valores que fueron afectados
    
    * Esto devolverá el ID del nuevo empleado insertado.
*/
    INSERT INTO empleados (nombre) VALUES ('Ana') RETURNING id;

/*
? LIKE / ILIKE
    -> Son operadores de la clausula "WHERE" de las sentencias select.
    -> LIKE : Busqueda distinguiendo MAYUSCULAS y Minusculas 
    -> ILIKE : no distingue las letras

    El % es un comodín que representa cualquier secuencia de caracteres (cero o más caracteres). En este contexto, significa que puede haber cero o más caracteres antes y después de "john", sin esos porcentajes la busqueda debe ser exacta , ningun caracter extra

    * Supongamos que deseas encontrar todos los empleados cuyos nombres contienen la palabra "John" en cualquier parte del nombre, sin importar si es mayúsculas o minúsculas:
*/
    SELECT nombre FROM empleados WHERE nombre ILIKE '%john%';

/*
? IS / IS NOT
    -> Operadores de la clausula "WHERE" de las sentencias SELECT para comprar valores NULL.

    -> IS : verificar si un valor es nul 
    -> IS NOT: verificar si un valor no es NULL

    * Supongamos que deseas encontrar todos los empleados cuyo salario no está especificado (es NULL):
*/
    SELECT nombre FROM empleados WHERE salario IS NULL;

/*
! Esto devolverá todos los empleados cuyo salario es NULL, es decir, no se ha especificado un salario para ellos.
*/
    