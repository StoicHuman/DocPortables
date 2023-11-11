/*

TODO: 📌ACTION - POSTGRESQL📌

? RESTRICT 
        -> La llave foranea que une las 2 tablas , al aplicar este action , postgre limita los cambios , osea que si el id del pasajero cambia de formato etc , la tabla que recibe el dato foraneo osea "trayecto" , no reflejara el cambio

? CASCADE
        -> Si la tabla de origen cambia , tambien cambia el de referencia

? SET NULL
        -> Cuando haya un cambio en la tabla principal , el dato se cambia a null

? SET DEFAULT 
        -> Cuando haya un cambio en la tabla principal , se usara el dato default (en caso lo hayamos creado)
*/

/* 
* Ejemplo Llave Foranea
*/

ALTER TABLE public.trayecto
    ADD CONSTRAINT  trayecto_estacion_fkey FOREIGN KEY (id_estacion)
    REFERENCES public.estacion(id) MATCH SIMPLE 
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

ALTER TABLE public.trayecto
    ADD CONSTRAINT  trayecto_tren_fkey FOREIGN KEY (id_tren)
    REFERENCES public.tren(id) MATCH SIMPLE 
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;