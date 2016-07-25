# Register Individual Account from site

#### Objetivos

El presente caso de uso describe como comenzar la registracion desde el site para convertirse en una individual account.

#### Precondiciones

La configuracion de Fielo tiene que estar completa siguiendo el documento [Fielo Package Installation & Setup](?name=UC-PTF-MN000)

El componente Register esta configurado en una page accesible desde el site relacionado al program.

En el componente Register esta configurado el modo de la registracion en caso que la cuenta CRM no exista (Person Account, Creacion de cuenta CRM o relacion a cuenta CRM especifica)

#### Postcondiciones

Individual Account creada

#### Flujo Basico

##### La individual account que se registra no existe en el program, existe el contacto y la cuenta CRM. La cuenta CRM no esta relacionada a ninguna Fielo Organization Account. Sin proceso de aprobacion

1. El member accede a la pagina de registracion en el site del program al que se quiere registrar.
2. El sistema muestra la pagina de registracion con:
	- Los campos y subcomponentes seleccionados en el fieldset del componente Registration
	- El boton Submit
3. El member completa los datos y presiona el boton Submit
4. El sistema valida que los campos esten completos y validos
5. El sistema valida que no existe una individual account con el email ingresado en el program en el que se intenta registrar
6. El sistema valida que no existe una individual account con el email ingresado en otro program
7. El sistema valida que existe el contacto con el email ingresado
8. El sistema valida que el contacto esta relacionado a una CRM Account
9. El sistema valida que la cuenta CRM a la que esta asociada el contacto no tenga relacionada una Fielo Organization Account
10. El sistema crea la Fielo Individual Account con status New y lo relaciona a la cuenta CRM del contacto y al contacto.
11. El sistema crea un email de tipo Register para la fielo individual account recien creada, indicando program, link para continuar la registracion y receptor del email. 
12. El sistema envia el email template especificado en el workflow Register para continuar con la registracion y muestra el mensaje "Check your email to continue the registration process."
13. El member presiona el link recibido en el email 
14. El sistema valida que no existe aprobacion de usuarios en el program
15. El sistema invoca el caso de uso [Create User](?name=UC-PTF-ME024)
16. Fin de flujo.

### Flujos Alternativos

#### 1. El subcomponente Captcha esta seleccionado en el fieldset del componente Registration (paso 2 del flujo basico)

1. El sistema verifica que el captcha esta seleccionado en el fieldset del componente
2. El sistema valida que los campos app y app secret del componente esten completos y validos.
3. El sistema muestra la pagina de registracion con:
	- Los campos configurados en el componente Registration
    - El captcha 
    - El boton submit
4. Continua en el paso 3 del flujo basico

#### 2. El member no completa los datos en pantalla de registracion (paso 4 del flujo basico)

1. El sistema verifica que los datos no estan completos
2. El sistema muestra el mensaje de error correspondiente
3. Continua en el paso 3 del flujo basico.

#### 3. El member cargo datos invalidos en la pantalla de registracion  (paso 4 del flujo basico)

1. El sistema verifica que los datos no son validos
2. El sistema muestra el mensaje de error correspondiente
3. Continua en el paso 3 del flujo basico.

#### 4. El member se intenta registrar con un email de un individual account que ya existe en el program con status Complete, Rejected o Pending (paso 5 del flujo basico)

1. El sistema verifica que el email con el que el member se esta intentando registrar ya existe en el program con status complete, rejected o pending
2. El sistema muestra el mensaje de error correspondiente
3. Continua en el paso 3 del flujo basico.

#### 5. El member se intenta registrar con un email que ya existe en otro program (paso 6 del flujo basico)

1. El sistema crea la Fielo Individual Account con status New para el program que se esta registrando y lo relaciona a la cuenta CRM relacionada al individual account existente. El sistema NO relaciona el contacto a la fielo Individual Account recien creada
2. Continua en el paso 11 del flujo basico 

#### 6. No existe el contacto y el modo de registracion seteado en el componente Register es Person Account (paso 7 del flujo basico)

1. El sistema chequea que en el componente Register el modo de registracion es Person Account
2. El sistema crea una nueva person account con los datos ingresados
3. El sistema crea la Fielo Individual Account con status New y lo relaciona a la person account recien creada
4. Continua en el paso 11 del flujo basico.

#### 7. No existe el contacto y el modo de registracion seteado en el componente Register es crear una nueva CRM (paso 7 del flujo basico)

1. El sistema chequea que en el componente Register el modo de registracion es nueva cuenta CRM
2. El sistema crea una nueva cuenta CRM con un nuevo contacto relacionado con los datos ingresados
3. El sistema crea la Fielo Individual Account con status New y lo relaciona al contacto y a la cuenta CRM recien creada
4. Continua en el paso 11 del flujo basico.

#### 8. No existe el contacto y el modo de registracion seteado en el componente Register es relacionar la fielo account a una cuenta CRM especificada (paso 7 del flujo basico)

1. El sistema chequea que en el componente Register el modo de registracion especifica una cuenta CRM al que relacionar el nuevo member
2. El sistema crea un nuevo contacto relacionado a la cuenta especificada con los datos ingresados
3. El sistema crea la Fielo Individual Account con status New y lo relaciona al contacto y a la cuenta CRM especificada
4. Continua en el paso 11 del flujo basico.

#### 9. El contacto no esta relacionado a una cuenta CRM y el modo de registracion seteado en el componente Register es Person Account (paso 8 del flujo basico)

1. El sistema chequea que en el componente Register el modo de registracion es Person Account
2. El sistema crea una nueva person account con los datos ingresados y no toma en cuenta el contacto existente
3. El sistema crea la Fielo Individual Account con status New y lo relaciona al person account recien creada
4. Continua en el paso 11 del flujo basico.

#### 10. El contacto no esta relacionado a una cuenta CRM  y el modo de registracion seteado en el componente Register es crear una nueva CRM (paso 8 del flujo basico)

1. El sistema chequea que en el componente Register el modo de registracion es nueva cuenta CRM
2. El sistema crea una nueva cuenta CRM con los datos ingresados y le relaciona el contacto
3. El sistema crea la Fielo Individual Account con status New y lo relaciona al contacto y a la cuenta CRM
4. Continua en el paso 11 del flujo basico.

#### 11. El contacto no esta relacionado a una cuenta CRM y el modo de registracion seteado en el componente Register es relacionar la fielo account a una cuenta CRM especificada (paso 8 del flujo basico)

1. El sistema chequea que en el componente Register el modo de registracion especifica una cuenta CRM al que relacionar el nuevo member
2. El sistema crea la Fielo Individual Account con status New y lo relaciona al contacto y a la cuenta CRM especificada
3. Continua en el paso 11 del flujo basico.

#### 12. La cuenta CRM a la que esta asociada el contacto tiene relacionado una Fielo Organization Account y no existe ninguna fielo account relacionada (paso 9 del flujo basico)

1. El sistema chequea que la cuenta CRM relacionada al contacto tiene una Fielo Organization Account relacionada
2. El sistema crea la Fielo Individual Account con status New y lo relaciona al contacto y a la cuenta CRM especificada. 
3. El sistema relaciona la Fielo Individual Account con la Fielo Organization Account.
4. El sistema marca como manager de la Fielo Organization Account a la nueva Individual Account.
5. Continua en el paso 11 del flujo basico.

#### 13. La cuenta CRM a la que esta asociada el contacto tiene relacionado una Fielo Organization Account y ya existen fielo accounts relacionadas (paso 9 del flujo basico)

1. El sistema chequea que la cuenta CRM relacionada al contacto tiene una Fielo Organization Account relacionada
2. El sistema crea la Fielo Individual Account con status New y lo relaciona al contacto y a la cuenta CRM especificada. 
3. El sistema relaciona la Fielo Individual Account con la Fielo Organization Account.
4. Continua en el paso 11 del flujo basico.

#### 14. Existe aprobacion de usuarios (paso 14 del flujo basico)

1. El sistema valida que el program tiene la marca de aprobacion de usuarios
2. El sistema muestra el mensaje indicando que para continuar con la registracion hay que presionar el boton Continue
3. El member presiona el boton Continue
4. El sistema cambia el status de la Fielo Individual Account a Pending y manda el member a aprobar.
5. El sistema muestra un mensaje al member indicando que la suspcripcion esta pendiente de aprobacion.
6. El administrador de la org aprueba la fielo Individual Account desde backend,ingresando al detalle de la fielo individual account
7. El sistema cambia el status de la Fielo Individual Account a Aproved
8. El sistema envia el email al member para finalizar la registracion
9. Continua en el paso 15 del flujo basico.

#### 15. El member se intenta registrar con un email de un individual account que ya existe en el program con status New (paso 5 del flujo basico)

1. El sistema verifica que el email con el que el member se esta intentando registrar ya existe en el program con status new
2. Continua en el paso 11 del flujo basico.
