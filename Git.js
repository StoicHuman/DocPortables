/*
* Configurar GitHub

    ? git config  --global user.name "Joaquin Anccana"

    ? git config  --global user.email "joaquin_eleuce@hotmail.com"
    
    ? git config -l 
                -> datos generales 

    ? git remote add origin urlgit 
                -> establecer el repositorio

    ? git remote -v 
                -> ver a que repositorio estamos conectados
    ? git pull origin master --allow-unrelated-histories
                ->  Si has creado un nuevo repositorio local y deseas sincronizarlo con un repositorio remoto existente que ya tiene un historial de commits, puedes utilizar --allow-unrelated-histories para permitir la fusión de los historiales , Esto es un MERGE por lo tanto se tiene que dejar un mensaje.
                    

TODO ==================== Flujo Basico =================================================
                ! git status -> git add -> git commit 

* STATUS 
        -> status nos indica que archivos cambiaron desde el pull que hiciste en la rama actual o desde tu ultimo commit

* ADD
        -> Lo que se hace antes de marcar un commit , es una verificacion de cambios realizados en archivos 

        ? git rm --cached historia.txt  
                    -> eliminar el add que se realizo en un archivo.
* COMMIT 
        -> Enviar los cambios al repositorio LOCAL

        ? git commit -m "mensaje del commit"

        ? git commit -am "mensaje del commit" 
                   -> Cotidianamente en un entorno de trabajo no crearemos archivos nuevos asi que esta es una manera abreviada de guardar los cambios en los archivos existentes y crear el commit 


TODO======================= Cambios en el Tiempo =================================

* LOG
        ? git log historia.txt

                    -> Sirve para mostar los cambios de un archivo(commits involucarados o si quieres ver en general , quita el nombre del archivo)
        
        ? git log --stat

                    -> el stat os detalla cuantos bits se cambio 
* SHOW
        ? git show historia.txt
                    -> nos muestra literalmente las diferencias del contenido que cambio en el archivo desde el ultimo commit que se hizo (actual)

* DIFF 
        ? git diff commit1 commit2
                    -> Este comando va de la par con los 2 anteriores pero sirve para comparar 2 commits atraves del hash (De preferencia colocar la mas vieja y la mas nueva , en ese orden )  

TODO======================= RAMAS / BRANCH =================================


* CHECKOUT

        ? git checkout hashdelcommit  -> PELIGROSO
                    ->  *Cabeza desprendida* , quiere decir que al hacer un checkout de un commit , estoy retrocediendo al commit pero dejo de encontrarme en alguna rama y pasamos a un "punto muerto" del repositorio

                    -> Serviria si queremos ver algun codigo pasado y luego regresar a nuestra rama , si en caso quisieramos hacer cambios con este commit pasado debemos crear una nueva rama con el siguiente codigo: 
                    
                    *"git checkout -b nueva-rama"

                    -> "-b" es para crear y a su vez movernos a dicha rama

        ? git checkout master
                    -> cambiar entre ramas 

        ? git checkout hashdelcommit historia.txt
                    -> En sintesis , retrocedes al commit indicado pero solo el archivo historia sufrira ese retroceso , sin el nombre del archivo todo sera afectado.

                    -> despues de hacer este checkout y hago un commit aun asi haya hecho cambios o no , el hash y el commit sera remplazado por uno nuevo(y seria la ultima version de la rama ) 
        
        ? git checkout master historia.txt
                    -> Es una manera de recuperar un archivo borrado en tu rama actual , en este caso estamos trayendonos el archivo que se elimino pero sera la version del ultimo commit hecho en master

                    -> Si hiciste esto pero no realizaste un commit , el archivo no se recuperara y tendras que volver a hacer este comando

* RESET
        ? git reset hashdelcommit --hard
                     -> Al agregarle la palabra hard , este reset nos traslada al commit que pongamos pero a su vez borra todas las versiones posteriores a este commit. 

        ? git reset hashdelcommit

                     -> el commit seleccionado se deshace y retrocedemos al commit anterior pero con los cambios del commit que se reseteo listo para hacerle git add . y git commit otra vez

* MERGE
        ? git merge cabecera (-m -> no se si funciona)

                     -> este comando se ejecuta en el head de la rama a la cual quieres que absorba el head de la rama que se pone en el comando.

                     -> tener en cuenta que un merge llega a ser un COMMIT entre 2 ramas por ende podemos poner un mensaje.

                     -> en caso las ramas al combinarse tienen una linea la cual se toco por ambos lados , es donde habra conflicto

                     !NOTA: 
                        La rama del merge no se borra sigue existiendo con su mismo historial , GIT NUNCA BORRA NADA

        ? MANEJO DE CONFLICTOS
                    -> Al tener lineas que se tocaron en las 2 ramas , git no procesara por completo el merge y tendremos que hacer un commit adicional para completarlo (despues de solucionar los conflictos claro)

                    -> En el caso de visual studio code , nos facilita mas la vida y nos ayuda a tomar la decision para saber si queremos el cambio actual o el cambio que viene , aunque basicamente si tuvieras que resolverlo de manera manual , borras la version que vas a descartar

                    -> despues de solucionar conflictos se hace 
                        * git commit -am "Solucione conflictos"

TODO======================= LLAVES / SSH =================================
-> Jamas se configura todo esto dentro de un repositorio local 

! LAS LLAVES JAMAS SE COMPARTEN , ES 1 POR PC 
        ? ssh-keygen -t rsa -b 4096 -C "joaquin_eleuce@hotmail.com"
                    -> Se genera la clave y podemos escoger donde guardar la clave aunque se recomienda el lugar predeterminado que da github asi que solo dale enter.

                    -> posiblemente te pida digitar una password para un doble cifrado pero puedes omitirlo dando enter

        ? eval$(ssh-agent -s) 
                    -> Es para prender el server y enlazar las llaves publicas y privadas

        ? ssh -add ~/.ssh/id_rsa
                    -> añadir al agente de llaves , nuestra llave privada


? SETTEAR LLAVE PUBLICA A PERFIL DE GITHUB

        *Entrar a :  SETTINGS -> SSH AND GPG KEYS 

        -> despues de configurar con todos los pasos anteriores debemos establecer la nueva url pero ya no sera https si no la de ssh

        ? git remote set-url origin urlRepoSSH 

        -> despues :  git pull origin master

        ! Despues de hacer todo esto ya tendriamos configurado un repositorio seguro donde solo nosotros podemos hacer cambios 
*/


