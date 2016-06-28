## Filter By Tag

### Objetivo

El presente caso de uso describe como el member puede filtrar rewards o content feed a traves del componente Filter by Tag

#### Precondiciones
Existen news creadas para un program, relacionados a tags del mismo program.

Existen rewards creados para el program, relacionados a tags del mismo program.

Existe una page con un componente catalog, un componente content feed, un componente Filter by Tag asociado a una navigation visible para el member. 

#### Postcondiciones

El componente catalogo fue filtrado por un tag.

#### Flujo de Eventos

#### Flujo Básico

1. El member accede a la navigation que muestra la page con el componente catalog y el componente Filter by Tag
2. El sistema muestra todos los tags del program al que esta relacionado el site para seleccionar
3. El member selecciona un tag
4. El sistema muestra en el componente catalogo los rewards relacionados al tag seleccionada
5. Fin de flujo.
	
#### Flujos Alternativos

##### 1. El member quiere sacar el filtro por tag 

1. El member vuelve a hacer click sobre el tag seleccionado
2. El sistema desmarca el tag y vuelve a mostrar todo el contenido del componente 
3. Fin de flujo.