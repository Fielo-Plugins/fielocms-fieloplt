# Select Fielo Account

#### Objetivos

El presente caso de uso describe como un usuario de site selecciona con que fielo account desea operar

#### Precondiciones

La configuracion de Fielo tiene que estar completa siguiendo el documento [Fielo Package Installation & Setup](http://documentation.fielo.com/docs/fielo-platform-cms-packages)

El componente MemberSelection esta configurado en una page de CMS con los subcomponentes LoginAsMember y LoginAsManager

#### Postcondiciones

El member opera en el site con el member seleccionado

#### Flujo Basico


1. El member ingresa a la page configurada con el componente Member Selection
2. El sistema muestra la page seteada en el campo SelectionMember: 
	- Listado de Members relacionados al user mostrando los campos seleccionados en el fieldset y el boton LoginAsMember por cada uno de los members que no estan bloqueados. 
	- Para los members que son manager, muestra el boton LoginAsManager  
3. El member selecciona otro member con el que quiere operar
4. El sistema guarda en el custom setting Frontend Session Data el ID del member seleccionado
5. Fin de flujo.

### Flujos Alternativos

### 1. El user tiene relacionado mas de un member y alguno esta bloqueado (paso 2 de flujo basico)

1. El sistema no muestra la opcion LoginAsMember O LoginAsManager para el member que esta bloqueado
2. Continua el paso 7 del flujo basico.

