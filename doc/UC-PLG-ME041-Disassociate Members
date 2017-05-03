# Disassociate Members

#### Objetivos

El presente caso de uso describe como un manager desvincula la operacion de members relacionados a la organization de la que es manager a traves del bloqueo

#### Precondiciones

El member logueado en el frontend es Manager de una organization account.
Existe una page con el componente Organization Members y el subcomponente Disassociate

#### Postcondiciones

Se desvincularon members relacionados a la organization account bloqueando su operatoria con la organization.

#### Flujo Basico

### El manager quiere desvincular un member de tipo contributor

1. El manager accede a la page en el que esta configurado el componente Organization Members
2. El sistema valida que el member logueado opera como organization account
3. El sistema muestra el listado de members relacionados a la Organization Account de la que es manager el member logueado y la opcion Disassociate para cada uno de los members
4. El manager selecciona un member de tipo contributor de la lista relacionada no esta bloqueado y elige la opcion Disassociate
5. El sistema muestra un mensaje de confirmacion
6. El manager confirma
7. El sistema bloquea el member
8. Fin de flujo.

### Flujos Alternativos

#### 1. El member logueado no opera como Organization account (paso 2 del flujo basico)

1. El sistema verifica que el member logueado no opera como una organization account
2. El sistema no muestra el componente Organization Members
3. Fin de Flujo

#### 2. El manager quiere desvincular un member relacionado a la organization account que a su vez es Individual Account (paso 4 del flujo basico)

1. El sistema verifica que el member seleccionado es de tipo Individual Account
2. El sistema elimina la relacion entre el individual account y la organization account
3. El sistema desmarca el campo synchronized
4. Fin de flujo.

#### 3. El manager quiere vincular un member de tipo contributor (paso 4 del flujo basico)

1. El manager selecciona un member de tipo contributor de la lista relacionada que esta bloqueado y elige la opcion Disassociate
2. El sistema muestra un mensaje de confirmacion
3. El manager confirma
4. El sistema desbloquea el member
5. Fin de flujo.
