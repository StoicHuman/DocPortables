/*

TODO: 📌Insercion y consulta de Datos📌
* Agregar y consultar datos
*/

INSERT INTO public.estacion(
    nombre,direccion)
    VALUES ('Estacion Centro','ST 1#12' )

INSERT INTO public.tren(
    modelo,capacidad)
    VALUES ('100','Renault' )

/* Esta tabla tiene datos de llaves foraneas de la tabla estacion y tren por lo tanto tienes que colocar datos existentes*/

/* Como la tabla trayecto esta configurada con "CASCADE"  y se actualiza siempre que hayan cambios , al eliminar el id 1 de tren o estacion , el registro de trayecto se anula */
INSERT INTO public.trayecto(
    id_estacion,id_tren,nombre)
    VALUES ('1','1' , 'Ruta 1' )

/* 
TODO:🔧 INSERCION MASIVA 🔧

? MOCKAROO.COM -> pagina para que nos dé varios datos dependiendo la estructura de la tabla
*/

