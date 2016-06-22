# View Organization Profile

#### Objetivos

El presente caso de uso describe como un member relacionado a una organization account visualiza los datos de la misma

#### Precondiciones

El componente Organization Profile esta configurado en una page accesible desde el site relacionado al program.

#### Postcondiciones



#### Flujo Basico

##### El member logueado esta relacionado a una organization account 

1. El member accede a la page en el que esta configurado el componente Organization Profile
2. El sistema valida que el member esta relacionado a una Organization Account
3. El sistema muestra el detalle de la Organization Account a la que el member esta relacionado, mostrando los campos de la organization account seleccionados en el fieldset del componente Organization Account.
4. Fin de flujo.

### Flujos Alternativos

#### 1. El member logueado no esta relacionado a una organization account (paso 2 del flujo basico)

1. El sistema verifica que el member logueado no esta relacionado a una organization account
2. El sistema no muestra el componente 
3. Fin de Flujo


