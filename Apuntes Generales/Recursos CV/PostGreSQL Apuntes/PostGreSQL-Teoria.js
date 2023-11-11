/*

TODO: 📌Comandos consola SQL SHELL (psql)📌

    *>  \? 
            -> Para acceder a todos los comandos permitidos en la consola
    *>  \l
            -> Enlistar las bases de datos instaladas 
    *>  \c nombrebd
            -> conectarte a una base de datos
    *>  \dt
            -> Enlistar las tablas de la base de datos donde te encuentres
    *>  \d nombretabla
            -> La informacion de la tabla.

    *>  \g
            -> te permite repetir ejecutar el ultimo comando que usaste sin necesidad de repetirlo, sirve para ver que comando se ejecuto desde otro computador conectado al server
    *>  \timing
            -> activas el contador , para que cada comando este con un cronometro y se sepa cuanto demora la consulta       
    ? tambien puedes ejecutar consultas de SQL , pero si no tiene ";" al final y le das enter , la consulta seguira activa y estaras dando un salto de linea.


TODO: 📌Archivos de configuracion📌 

    *> postgresql.conf 
             -> es importante leer todas las configuraciones de una bd que te puedan dar para que entiendas los conflictos que pueden pasar.

             -> La seccion "- Settings -" -> es la configuracion actual de tu bd , si quieres cambiar algunos de esos comandos , lo descomentas y modificas , para que el cambio sea reflejado , tienes que reiniciar el servicio de la bd
    
    *> pg_hba.conf
             -> Archivo encargado de los roles y tipos de acceso a tu base de datos

             -> se resume en 5 columnas , tipo de conexion , quienes  se pueden conectar , la direccion de donde se conectan y el metodo de autenticacion.

             -> Si configuramos mal el archivo nisiquiera nosotros mismos podremos entrar
    *> pg_ident.conf
             -> Configuracion para que usuario del windows donde esta ejecutandose postgress tenga un roll  , admin , superadmin etc
    

    para saber donde estan, en QUERY TOOL escribes

    ? SHOW config_file;


TODO: 📌Particiones📌


        
*/