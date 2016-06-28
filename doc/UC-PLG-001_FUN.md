## Configure Register Component 

### Objetivos

El presente caso de uso describe la configuracion del Componente Register

### Precondiciones

El administrador debe estar logueado a la ORG administradora de Fielo.
Existe una page con un componente Register 

### Postcondiciones

Componente Register configurado

### Flujo de Eventos

### Flujo Basico

### El administrador quiere que durante la registracion por frontend, si el contacto no existe en el CRM se cree una nueva Person Account.

 1. El administrador ingresa al detalle de la page que tiene el componente Register
 2. El sistema muestra el detalle de la page, con el componente Register y los iconos de modificacion y eliminacion de componente. 
 3. El administrador presionar el icono de modificacion de componente
 4. El sistema muestra el detalle del componente Register con las secciones
    - General: con los campos Component Name, Page / Template, Title	
    - Responsive: con los campos Desktop, Mobile y Tablet
    - Captcha: con los campos Captcha Public Key y Captcha Secret Key	
    - View: con los campos Layout y Detail parameter	
    - Account CRM Creation: con los campos Account CRM Mode (con las opciones Person Account, Standard Account y Defined Account) y el campo Account CRM Owner
 5. El administrador selecciona la opcion Person Account 
 6. El sistema valida que la org tenga habilitado el feature Person Account
 7. El administrador selecciona un user en el campo Account CRM Owner 
 8. El sistema valida que el user seleccionado tenga un Rol definido.
 9. El Administrador presiona el boton Save.
10. El sistema guarda la configuracion del componente Register.

### Flujos Alternativos

##### 1. El administrador quiere que durante la registracion por frontend, si el contacto no existe en el CRM se cree una nueva Account CRM Standard. (paso 4 del flujo basico)
1. El member selecciona la opcion Standard Account
2. Continua en el paso 7 del flujo basico

##### 2. El administrador quiere que durante la registracion por frontend, si el contacto no existe en el CRM se relacione a una Account CRM especifica. Selecciona la CRM Account (paso 4 del flujo basico)

1. El member selecciona la opcion Defined Account
2. El member selecciona la account a la que los nuevos members seran relacionados y presiona el boton Save
3. El sistema guarda la configuracion del componente Register
4. Fin de flujo.

##### 3. El administrador quiere que durante la registracion por frontend, si el contacto no existe en el CRM se relacione a una Account CRM especifica. NO selecciona la CRM Account (paso 4 del flujo basico)

1. El member selecciona la opcion Defined Account
2. El member NO selecciona la account a la que los nuevos members seran relacionados y presiona el boton Save
3. El sistema muestra un mensaje de error
4. Fin de flujo.

##### 4. La org no tiene habilitada la funcionalidad Person Account (paso 6 del flujo basico)

1. El sistema valida que el member selecciono la opcion Person Account y la ORG no tiene habilitada dicha funcionalidad
2. El sistema muestra un mensaje de error especificando el problema
3. Fin de flujo

##### 5. El campo Account CRM Owner esta vacio (paso 7 del flujo basico)

1. El sistema valida que el member seleccion la opcion Person Account o Standar Account y no selecciono Account Owner
2. El sistema muestra un mensaje de error especificando el problema
3. Fin de flujo

##### 6.El user seleccionado en el campo CRM Owner no tiene Rol (paso 8 del flujo basico)

1. El sistema valida que el user seleccionado en el campo CRM Omember seleccion la opcion Person Account o Standar Account y no selecciono Account Owner
2. El sistema muestra un mensaje de error especificando el problema
3. Fin de flujo

