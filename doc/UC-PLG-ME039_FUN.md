# Set Manager from site

#### Objetivos

El presente caso de uso describe como un manager de una organization profile puede setear a otros members relacionados a la organization account como manager.

#### Precondiciones

El member logueado en el frontend es Manager de una organization account.
Existe una page con el componente Organization Members y el subcomponente Set Manager

#### Postcondiciones

La Organization Account tiene definido nuevos managers

#### Flujo Basico

1. El manager accede a la page en el que esta configurado el componente Organization Members
2. El sistema valida que el member logueado opera como organization account
3. El sistema muestra el listado de members relacionados a la Organization Account de la que es manager el member logueado y la opcion Set Manager para cada member de la lista
4. El manager selecciona un member de la lista relacionada y elige la opcion Set Manager
5. El sistema invoca el caso de uso [Set Manager](?name=UC-PTF-ME034)
6. Fin de flujo.

### Flujos Alternativos

#### 1. El member logueado no opera como Organization account (paso 2 del flujo basico)

1. El sistema verifica que el member logueado no opera como una organization account
2. El sistema no muestra el componente Organization Members
3. Fin de Flujo

#### 2. El manager se selecciona a si mismo en la lista (paso 4 del flujo basico)

1. El sistema verifica que el member que deja de ser manager es el que esta operando como organization account 
2. El sistema muestra un mensaje informando que cuando se desloguee no podra volver a operar en nombre de la organization account. Las opciones aceptar y cancelar.
3. El member presiona la opcion Aceptar 
4. Continua en el paso 5 del flujo basico 
