## Tags Assignment

### Objetivo

El presente caso de uso explica como relacionar un tag a un reward, banner o content feed

### Precondiciones

### Postcondiciones

El tag seleccionado fue relacionado al reward, banner o content feed

### Flujo Basico

1. El sistema muestra la pagina de asignacion de Tags con la siguiente informacion
    - Lista de tags del mismo program con un checkbox para seleccionar y la siguiente informacion: Name e Imagen 
    - Los botones Save y Cancel
2. El administrador selecciona un tag marcando el checkbox y presiona el boton Save
3. El sistema relaciona el tag al objeto
4. El sistema regresa al detalle del reward, banner o content feed

### Flujos Alternativos

#### 1. El administrador presiona el boton Save sin seleccionar un tag (paso 3 del flujo basico)

1. El administrador presiona el boton Save sin marcar un tag
2. El sistema muestra un mensaje de error 
3. The system back to reward view

##### 3. El administrador presiona el boton Cancel (paso 3 del flujo basico)

1. El administrador presiona el boton Cancel
2. El sistema no relaciona el tag y vuelve al detalle del reward, banner o content feed


### Relaciones de extension
Manage Banner

Manage Content Feed

Manage Reward