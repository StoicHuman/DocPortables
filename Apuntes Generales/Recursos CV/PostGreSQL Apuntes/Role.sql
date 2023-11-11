/* 
TODO: 📋 Roles 📋
    -> Los roles se tratan como un gestor de permisos para los diversos usuarios que interactuan con la bd , evitando errores garrafales como borrar toda la bd en un descuido etc
*/

CREATE ROLE usuario_consulta;
ALTER ROLE usuario_consulta WITH LOGIN; /*Asignar opcion*/
ALTER ROLE usuario_consulta WITH SUPERUSER;
ALTER ROLE usuario_consulta WITH PASSWORD 'contraseña123';

DROP ROLE usuario_consulta; /*desde otro usuario que no sea este*/
/*
? Al crear un role , tienes que asignarle optiones de sequelize , caso contrario no podra hacer nada , a diferencia de las tablas las cuales si no pones nada , se le asigna por defecto.

* 1) LOGIN / NOLOGIN
            ->  permite que un rol inicie sesión en la base de datos, lo que significa que puede conectarse a la base de datos. La opción NOLOGIN se utiliza para crear roles que no pueden iniciar sesión y, por lo tanto, no pueden conectarse a la base de datos.
* 2) SUPERUSER
            -> le otorgas privilegios de superusuario en la base de datos, lo que significa que el rol tiene control total sobre el sistema de gestión de bases de datos y puede realizar cualquier acción.
* 3) CREATEDB
            -> permite que un rol cree nuevas bases de datos. Esto es útil si deseas que un usuario pueda crear bases de datos en el servidor PostgreSQL.
* 4) CREATEROLE
            -> concede al rol el permiso para crear otros roles. Si habilitas esta opción, el rol puede crear nuevos roles de usuario y asignarles permisos.
* 5) INHERIT
            -> controla si un rol hereda los privilegios y roles de otros roles. Cuando se establece en INHERIT, el rol hereda los privilegios de los roles de los que es miembro.
* 6) LOGIN ROLE 
            -> Puedes asignar a un rol la capacidad de actuar como un rol de autenticación para otros roles. Esto es útil cuando deseas crear un rol que puede ser utilizado como un rol "proxy" para fines de autenticación.
* 7) CONNECTION LIMIT
            -> Esta opción limita el número máximo de conexiones simultáneas que un rol puede tener. Puedes usar esto para controlar el acceso y la utilización de recursos.
* 8) PASSWORD 
            -> Puedes asignar una contraseña a un rol mediante la opción PASSWORD. Esto permite que el rol inicie sesión en la base de datos proporcionando la contraseña correcta.
* 9) ENCRYPTED PASSWORD 
            -> Si deseas especificar una contraseña encriptada para un rol en lugar de una contraseña en texto claro, puedes hacerlo utilizando esta opción.
* 10) VALID UNTIL 
            -> Esta opción permite establecer una fecha de caducidad para el rol. Después de la fecha especificada, el rol ya no podrá iniciar sesión.
* 11) WITH ADMIN OPTION 
            -> Al asignar roles a otros roles, puedes utilizar la opción WITH ADMIN OPTION para permitir que el rol que otorga el permiso también pueda otorgar ese permiso a otros roles.

TODO: 🔓 Permisos "GRANT" 🔧
    -> Son permisos especiales para un usuario el cual sus permisos no le permiten hacer ciertas acciones , los permisos se le otorgan para alguna tabla , objeto , esquema , etc pero se hace individualmente.
*/

GRANT SELECT, INSERT, UPDATE, DELETE ON nombre_de_tabla TO nombre_de_rol;

GRANT USAGE ON SCHEMA nombre_de_esquema TO nombre_de_grupo;

GRANT EXECUTE ON FUNCTION nombre_de_funcion(argumentos) TO nombre_de_rol;

GRANT CONNECT ON DATABASE nombre_de_base_de_datos TO nombre_de_usuario;

GRANT CREATEDB TO nombre_de_usuario;