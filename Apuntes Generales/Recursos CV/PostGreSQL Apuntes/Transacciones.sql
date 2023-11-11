/*

TODO: 👀 Transacciones 📚
    -> En la gestion de datos , transacciones representa un bloque de codigo que ejecutara diversas sentencias sin embargo al cumpli con las normas ACID si alguna de las operaciones falla , la bd volvera a como estaba antes de ejecutar el codigo (se deshara las sentencias ejecutadas).

    Es todo o nada .
*/


--*  Supongamos que tenemos una tabla llamada cuentas con dos columnas: id y saldo. Queremos transferir dinero de una cuenta a otra en una transacción para garantizar la atomicidad y la consistencia de la operación. Aquí tienes un ejemplo en PostgreSQL:


-- Comenzar una transacción
BEGIN;

-- Actualizar el saldo de la cuenta de origen (restar el monto)
UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;

-- Actualizar el saldo de la cuenta de destino (sumar el monto)
UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;

-- Confirmar la transacción
COMMIT;





--* La palabra clave ROLLBACK se utiliza para deshacer (o revertir) una transacción en PostgreSQL. Si se produce un error o una condición que requiere la cancelación de una transacción, puedes utilizar ROLLBACK para deshacer todas las operaciones realizadas en la transacción y restaurar la base de datos a su estado original.

--? Supongamos que estamos realizando una transferencia de fondos entre dos cuentas bancarias en una transacción, como en el ejemplo anterior:


-- Comenzar una transacción
BEGIN;

-- Actualizar el saldo de la cuenta de origen (restar el monto)
UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;

-- Introducir un error (por ejemplo, una validación fallida)
-- Esto podría ser una condición de negocio que impide continuar la transacción
-- Por ejemplo, si el saldo de la cuenta de origen es insuficiente
IF saldo < 100 THEN
    -- Deshacer la transacción y restaurar el saldo original
    ROLLBACK;
ELSE
    -- Actualizar el saldo de la cuenta de destino (sumar el monto)
    UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;

    -- Confirmar la transacción
    COMMIT;
END IF;

