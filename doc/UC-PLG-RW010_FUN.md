## I Like Reward

#### Objetivo

El presente caso de uso describe como el member puede marcar marcar o desmarcar un reward del catalogo como "Like"

#### Precondiciones

El member tiene que estar logueado al site. 

Existen rewards creados para el program.

Existe una page con un componente catalog asociado a una navigation visible para el member. 

En el [fieldset del componente](?name=UC-PTF-FE006) esta agregado el subcomponente Like 

#### Postcondiciones

Se creo o elimino una relacion de Like entre el member y un reward determinado.

#### Flujo de Eventos

#### Flujo Básico

1. El member accede a la navigation que muestra la page con el componente catalog
2. El member presiona el icono Like en el detalle del reward
3. El sistema crea una nueva relacion entre el member y el reward
4. El sistema muestra el icono de Like de color azul en el reward
5. Fin de flujo.
	
#### Flujos Alternativos

##### 1. El member quiere desmarcar un reward que fue marcado como Like (paso 4 del flujo basico)

1. El member presiona el icono Like del reward que ya fue marcado 
2. El sistema elimina la relacion entre el member y el reward
3. El sistema muestra el icono de Like de color gris en el reward
3. Fin de flujo.

