## Recover Password
### Objetivo

El presente caso de uso describe el cambio de password por un member que solo recuerda su usuario.

### Precondiciones

El componente de Login tiene que estar configurado.

### Postcondiciones

El member resetea su password y obtiene una password temporal. 

### Flujo de Eventos

### Flujo Basico

1. El member accede al sitio configurado de Fielo.
2. El member accede al menu de Login.
3. El member presiona el link ‘Forgot password’   
4. El sistema refresca la pagina y muestra el mensaje ‘Did you forget your password? Please enter your user name below.’ junto a un campo para completar el username. El boton Submit y el link Back  
5. El member ingresa el usuario
6. El member presiona el boton Submit
7. El sistema valida que el usuario se haya ingresado en el formato correcto.
8. El sistema valida que el usuario exista
9. El sistema envia un mail al member con una password temporal 
10. El sistema muestra el siguiente mensaje:  ‘An email has been sent to you with your temporary password’. y el link 'Go to Home'
11. El member recibe un email con su usuario y password temporal
12. El member reseteo su password

### Flujo Alternativo

#### 1. El member ingresa un username en formato incorrecto (paso 7 del flujo basico)
1. El sistema verifica que el formato ingresado del username es incorrecto y muestra el mensaje de error correspondiente
2. Continua en el paso 4 del flujo basico

#### 2. El member ingresa un username que no existe (paso 8 del flujo basico)
1. El sistema verifica que el username no existe y muestra el mensaje de error correspondiente
2. Continua en el paso 4 del flujo basico

#### 3. El member presiona el link Back (paso 4 del flujo basico)
1. El sistema muestra la home del Site
2. Fin de flujo

#### 4. El member presiona el link Go To Home (paso 10 del flujo basico)
1. El sistema muestra la home del Site
2. Fin de flujo

#### 5. El member tiene el user inactivo (paso 6 del flujo basico)
1. El sistema activa nuevamente al usuario
2. Continua en el paso 9 del flujo basico

#### 6. No se ingresa el usuario (paso 4 del flujo basico)
1. El sistema muestra un mensaje de error
2. Fin de flujo

#### 7. El usuario no existe (paso 6 del flujo basico)
1. El sistema muestra un mensaje de error
2. Fin de flujo



