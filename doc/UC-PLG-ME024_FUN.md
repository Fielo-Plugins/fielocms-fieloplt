## Create User


### Objetivos

El presente caso de uso describe como un member completa la registracion desde frontend y el sistema crea su usuario.

### Precondiciones

- El componente Register2 esta configurado en una page de CMS. 

- En el program, el campo RegisterPage tiene la page de CMS con el componente Register2.

- El member comenzo la registracion desde Frontend o el administrador comenzo la registracion desde backend

### Postcondiciones

El member completa la registracion en el site y el sistema genera el user para el mismo.

### Flow Basico

1. El member presiona el link en el mail recibido
2. El sistema verifica que el id del member recibido exista
3. El sistema verifica que el status del member es New o Approved y que la Fielo Account no es de tipo Organization Account
4. El sistema verifica que existen campos configurados en el fieldset de Register del objeto Member
5. El sistema muestra el site con la pagina de registracion con:
	- Los campos configurados en el fieldset del objeto
	- Los campos password y confirm password
	- El boton Submit
6. El member completa los campos
7. El member presiona el boton Submit
8. El sistema verifica que los campos esten completos y validos
9. El sistema verifica que la fielo account no tiene user
10. El sistema crea un nuevo usuario relacionado a la Fielo Account y a su contact relacionado con la password configurada por el member en la segunda pagina de Registracion y con el language, time zone y locale seteado en el program. 
10. El sistema actualiza el status de la Fielo Account a Complete y cambia el owner al user recien creado.
11. El sistema calcula el Level del Member invocando el caso de uso [LevelAssignmentBatchSchedule](?name=UC-PTF-IN000)
12. El sistema loguea al member invocando el caso de uso [Validar Login](?name=UC-PLG-ME009)
13. Fin de flujo.

### Flow Alternativo

##### 1. El sistema verifica que el member id recibido en el link del mail no existe (paso 2 del flujo basico)

1. El sistema verifica que el member no existe
2. El sistema muestra el mensaje de error correspondiente
3. Fin de flujo.

##### 2. El status de la fielo account es Pending (paso 3 del flujo basico)

1. El sistema verifica que el status de la Fielo Account es Pending
2. El sistema muestra un mensaje de error indicando que la fielo account esta pendiente de aprobacion
3. Fin de flujo

##### 3. El status de la fielo account es Rejected (paso 3 del flujo basico)

1. El sistema verifica que el status de la Fielo Account es Rejected
2. El sistema muestra un mensaje de error indicando que la fielo account no fue aprobada
3. Fin de flujo

##### 4. El status de la fielo account es Completed (paso 3 del flujo basico)

1. El sistema verifica que el status de la Fielo Account es Completed
2. El sistema muestra un mensaje de error indicando que la fielo account ya es member
3. Fin de flujo

##### 5. La fielo account es una organization account (paso 3 del flujo basico)

1. El sistema verifica que la fielo account es una Organization Account
2. El sistema muestra un mensaje de error indicando que la Fielo Account indicada es una Organization Account.
3. Fin de flujo

##### 6. El member no confirmo correctamente la password ingresada  (paso 6 del flujo basico)

1. El sistema verifica que los campos password y confirm password no son iguales
2. El sistema muestra el mensaje de error correspondiente
3. Continua en el paso 14 del flujo basico.

##### 7. No se completan los datos obligatorios (paso 8 del flujo basico)

1. El sistema verifica que los datos no estan completos
2. El sistema muestra el mensaje de error correspondiente
3. Continua en el paso 14 del flujo basico.

##### 8. Se completan datos invalidos (paso 8 del flujo basico)

1. El sistema verifica que los datos no son validos
2. El sistema muestra el mensaje de error correspondiente
3. Continua en el paso 14 del flujo basico.

##### 9. El sistema valida que el member se elimino despues de cargar la pagina (paso 8 del flujo basico)

1. El sistema verifica que el member no existe
2. El sistema muestra el mensaje de error correspondiente
3. Fin de flujo.

##### 10. La fielo account tiene user (paso 9 del flujo basico)

1. El sistema verifica que la fielo account tiene user
2. El sistema muestra los campos configurados en el fieldset del componente Register Step2 sin posibilidad de completar la password
3. El member completa los datos y presiona el boton Submit
4. El sistema muestra el mensaje ""Your registration was succesful, please go to the home page and login with your user and password."
5. Fin de flujo



