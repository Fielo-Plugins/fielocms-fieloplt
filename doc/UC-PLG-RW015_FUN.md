## Filter by Category
#### Objetivo

El presente caso de uso describe como el member puede filtrar rewards o content feed a traves del componente Filter by categories 

#### Precondiciones
Existen news creadas para un program, relacionados a categorias del mismo program.

Existen rewards creados para el program, relacionados a categorias del mismo program.

Existe una page con un componente catalog, un componente content feed, un componente Filter by categories asociado a una navigation visible para el member. 

#### Postcondiciones

El componente catalogo fue filtrado por una categoria.

#### Flujo de Eventos

#### Flujo Básico

1. El member accede a la navigation que muestra la page con el componente catalog y el componente Filter by Category
2. El sistema muestra todas las categories del program al que esta relacionado el site para seleccionar
3. El member selecciona una categoria
4. El sistema muestra en el componente catalogo los rewards relacionados a la categoria seleccionada
5. Fin de flujo.
	
#### Flujos Alternativos

##### 1. El member quiere sacar el filtro por categoria 

1. El member vuelve a hacer click sobre la categoria seleccionada
2. El sistema desmarca la categoria y vuelve a mostrar todo el contenido del componente 
3. Fin de flujo.

