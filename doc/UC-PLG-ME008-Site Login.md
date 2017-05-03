## Site Login
### Objetivo

El presente caso de uso describe el proceso de login de un member al site


### Precondiciones

El member necesita tener usuario y contraseña, no estar logueado al sitio y que su estado sea Active.
El componente de Login tiene que asociado a una page accesible desde una navigation del site.

### Postcondiciones

El member se logueo correctamente al sitio.

### Flujo de Eventos

### Flujo Basico

1. El member accede al sitio configurado de Fielo.
2. El member accede al menu de Login.
3. El sistema muestra los campos Email y contraseña y el link "Olvide mi contraseña?"
4. El member ingresa su email y contraseña y presiona el boton Enviar.
5. El sistema valida usuario y contraseña.
6. El sistema valida que el member no tiene password temporal
7. El sistema valida que el status del member sea Active
8. El sistema invoca al caso de uso [Validar Login](?name=UC-PLG-ME009)

### Flujos Alternativos

#### 1. El member ingresa email o password invalidos (paso 4 del flujo basico)

1. El sistema verifica que los campos no son validos y muestra el siguiente mensaje de error: "Error: Your login attempt has failed. Make sure the username and password are correct’. 
2. Continua en el paso 3 del flujo basico. 

#### 2. El member no completa el campo Email (paso 4 del flujo basico)

1. El sistema verifica que los campos no son validos y muestra el siguiente mensaje de error: ‘Error: Enter a value in the User Name field.’ 
2. Continua en el paso 3 del flujo basico. 

#### 3.  El member no completa el campo password (paso 4 del flujo basico)

1. El sistema verifica que los campos no son validos y muestra el siguiente mensaje de error: ‘Error: Enter a value in the Password field.’ 
2. Continua en el paso 3 del flujo basico. 

#### 4. El member se esta logueando con una password temporal (paso 6 del flujo basico)
1. El sistema muestra la pagina configurada para cambio de password en el site.
2. El member completa su nueva password
3. El member presiona el boton Change Password
4. Continua en el paso 7 del flujo basico

#### 5. El status del member es distinto que Active (paso 7 del flujo basico)

1. El sistema valida que el status del member es distinto que active
2. El sistema muestra un mensaje de error. 
3. Fin de flujo

#### 6. El member presiona el link "Forgot Password" (paso 4 del flujo basico)
1. El sistema invoca el caso de uso [Recover Password](?name=UC-PLG-ME012)
2. Fin de flujo.


