## Validar Login
### Objetivo

El presente caso de uso describe las validaciones que realiza el sistema una vez que el member se loguea.

### Precondiciones

### Postcondiciones

### Flujo de Eventos

### Flujo Basico

 1. El sistema valida que el member no este bloqueado
 2. El sistema valida que el usuario no este inactivo.
 3. El sistema valida que el program usa agreement
 4. El sistema valida que existe un agreement en estado activo relacionado al member
 5. El sistema direcciona al member al menu principal del sitio.
 6. El sistema evalua todos los segments dinamicos activos y almacena en una cookie aquellos a los que el member aplica.
 7. El sistema almacena en una cookie todos los segments manuales relacionados al member
 8. El sistema muestra el frontend de acuerdo a los componentes visibles acorde a la segmentacion para el member que esta realizando el login.

### Flujos Alternativos

#### 1. El sistema valida que el member esta bloqueado (paso 1 del flujo basico)

1. El sistema verifica que el member esta bloqueado y muestra el siguiente mensaje de error: ‘Login is blocked. Please contact your administrator.' 
2. Fin de flujo 

#### 2. El sistema valida que el usuario esta inactivo (paso 2 del flujo basico)

1. El sistema verifica que el usuario relacionado al member esta inactivo.
2. El sistema activa el usuario relacionado al member.
3. Continua en el paso 3 del flujo basico. 

####3. El sistema valida que el program no usa agreement

1. El sistema ignora si hay agreements activos.
2. Continua en el paso 5 del flujo basico.

#### 4.  El sistema valida que el member no tiene agreement relacionado y la pagina de agreement es la estandar de Fielo (paso 4 del flujo basico)

1. El sistema verifica que existe un agreement con estado activo y no esta relacionado al member
2. El sistema muestra el agreement con la opcion de visualizarlo en PDF y la opcion "I agree"
4. El member presiona el boton "I Agree"
5. El sistema relaciona el member al agreement que acaba de aceptar.
6. Continua en el paso 5 del flujo basico.

#### 5.  El sistema valida que el agreement relacionado al member esta deprecado (paso 4 del flujo basico)

1. El sistema verifica que el agreement relacionado al member no es el mismo que el actual del programa
2. Continua en el paso 1 del flujo alternativo 4

