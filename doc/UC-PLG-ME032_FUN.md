## Invite Member to Organization

### Precondiciones

El member logueado en el frontend es Manager de una organization account.
Existe una page con el componente Organization Members, especificando en el campo Menu Redirect una page con el componente Register.

### Postcondiciones

Se crearon nuevos contributors relacionados a la organization account.

### Flujo de Eventos

### Flujo Basico

1. El member accede a la page en el que esta configurado el componente Organization Members
2. El sistema valida que el member logueado opera como organization account
3. El sistema muestra el listado de members relacionados a la Organization Account de la que es manager el member logueado y la opcion Invite
4. El member elige la opcion Invite
5. El sistema muestra un formulario para completar los datos requeridos para el nuevo contributor
6. El member completa los datos y presiona el boton Submit
7. El sistema invoca el caso de uso [Create Contributor] (?name=UC-PTF-ME025)en el paso 6 del flujo basico
8. Fin de flujo.

### Flujos Alternativos

#### 1. El member logueado no opera como una organization account (paso 2 del flujo basico)

1. El sistema verifica que el member logueado no opera como organization account
2. El sistema no muestra el componente Organization Members
3. Fin de Flujo

#### 2. El manager no completa los datos obligatorios (paso 6 del flujo basico)

1. El sistema verifica que el manager no completa los datos
2. El sistema muestra el mensaje de error correspondiente
3. Fin de Flujo

#### 3. El manager completa con datos invalidos (paso 6 del flujo basico)

1. El sistema verifica que el manager completa datos invalidos
2. El sistema muestra el mensaje de error correspondiente
3. Fin de Flujo

