# Manage Pending Invitations

#### Objetivos

El presente caso de uso describe como un manager de una organization profile puede visualizar las invitaciones pendientes (members de la organization account con status new) para reenviarlas o cancelarlas.

#### Precondiciones

El member logueado en el frontend es Manager de una organization account.
Existe una page con el componente Organization Members configurado y los subcomponentes Resend y Cancel

#### Postcondiciones

Se actualizaron las invitaciones pendientes

#### Flujo Basico

1. El manager accede a la page en el que esta configurado el componente Pending Invitations
2. El sistema valida que el member logueado opera como organization account
3. El sistema muestra el listado de members con el status configurado en el componente relacionados a la Organization Account de la que es manager el member logueado y las opciones Resend o Cancel para cada uno de los members
4. El manager elige la opcion Resend para un member
5. El sistema crea un email de tipo Register para el member seleccionado
6. El sistema reenvia el email template asociado al workflow que se dispara con el email Register al member seleccionado
7. Fin de flujo.

### Flujos Alternativos

#### 1. El member logueado no opera como Organization account (paso 2 del flujo basico)

1. El sistema verifica que el member logueado no opera como una organization account
2. El sistema no muestra el componente Organization Members
3. Fin de Flujo

#### 2. El manager quiere cancelar la invitacion (paso 3 del flujo basico)

1. El manager elige la opcion cancelar para un member de la lista 
2. El sistema muestra el mensaje: "Eliminara el member pendiente. Esta seguro?"
3. El manager presiona confirmar
4. El sistema elimina el contributor
5. Fin de flujo.

#### 3. Existen members con status distinto de new (paso 3 del flujo basico)

1. El listado de members tiene status distinto de new
2. las opciones Resend o Cancel no se muestran para los members con status distinto de new. 
3. Fin de flujo.
