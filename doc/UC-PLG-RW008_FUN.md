## View Catalog Component

#### Objetivo

El presente caso de uso describe como el member ve el componente catalog en el site e interactua con los rewards. 

#### Precondiciones

El member tiene que estar logueado al site. 

Existen rewards creados para el program.

Existe una page con un componente catalog asociado a una navigation visible para el member. 

El componente catalog tiene una Detail Page relacionada con el componente reward detail.

En el [fieldset del componente](?name=UC-PTF-FE006) esta configurado de la siguiente forma,

- Subcomponentes Add to cart,Like y Wish
- Existe algun campo marcado como Link to Detail 
- Existe algun campo con el valor Enabled en el picklist Order by
- Existe un campo con el valor ASCENDING en el piclist Order by

#### Postcondiciones



#### Flujo de Eventos

#### Flujo Básico

1. El member accede a la navigation que muestra la page con el componente catalog
2. El sistema busca los rewards que cumplan las siguientes condiciones
	- Pertenezcan al mismo program del site
    - Cuyo stock sea mayor que cero o que el stock management sea "Unlimited"
    - No tenga fecha de expiracion o cuya fecha de expiracion sea mayor que la fecha actual.
3. El sistema evalua que el componente catalog no tenga asociados tags 
4. El sistema evalua que el componente catalog no tenga asociadas categories
5. El sistema evalua que el componente catalog no tenga la marca filter by segment chequeada  
6. El sistema evalua el campo layout del componente
7. El sistema muestra el componente acorde a la siguiente [configuracion](?name=UC-PTF-FE010)
8. El sistema evalua el fieldset del componente y muestra por cada reward: 
 	- Los campos y subcomponente seleccionados para mostrar
 	- Muestra como Link el campo setado como Linkt to Detail
9. El sistema evalua que campo del fieldset tiene el valor ASCENDING o DESCENDING en el picklist Order by y cuales el valor Enabled
10. El sistema muestra los rewards ordenados por el campo que tiene el valor ASCENDING o DESCENDING en el picklist Order by y un picklist para que el member cambie el orden de los rewards con la opcion de ascendente o descendente de todos los campos que tengan el valor ENABLED
11. El sistema evalua que el componente tiene el checkbox paging marcado
12. El sistema muestra el link Previous (grisado porque es la primer pagina) y el link Next. Y en cada pagina muestra la cantidad de rewards de acuerdo a lo ingresado en el campo Items per Page del componente catalog. 
13. Fin de flujo.
     
#### Flujos Alternativos

##### 1. El componente catalog tiene tags relacionados (paso 3 del flujo basico)

1. El sistema evalua que el componente tiene relacionado un tag
2. El sistema busca en los rewards que son del mismo program, tienen stock mayor a cero y no estan expirados, aquellos tagueados por el mismo tag del componente
3. Continua en el paso 8 del flujo basico

##### 2. El componente catalog tiene categories relacionados (paso 4 del flujo basico)

1. El sistema evalua que el componente tiene relacionado una category
2. El sistema busca en los rewards que son del mismo program, tienen stock mayor a cero y no estan expirados, aquellos que tienen la misma category del componente
3. Continua en el paso 8 del flujo basico

##### 3. El componente catalog tiene la marca filter by segment (paso 5 del flujo basico)

1. El sistema evalua que el componente tiene la marca filter by category
2. El sistema filtra todos los rewards que tienen segments y valida que el member cumpla dicho segment 
3. Continua en el paso 8 del flujo basico

##### 4. El member quiere agregar un reward (paso 11 del flujo basico)

1. El member presiona el boton Add to cart en el detalle del reward
2. El sistema invoca el caso de uso [Add Reward from Catalog](?name=UC-PTF-RW009)
3. Fin de flujo

##### 5. El member quiere likear un reward (paso 11 del flujo basico)

1. El member presiona el boton Add to cart
2. El sistema invoca el caso de uso [I Like reward](?name=UC-PTF-RW010)
3. Fin de flujo

##### 6. El member quiere wishear un reward (paso 11 del flujo basico)

1. El member presiona el boton Add to cart
2. El sistema invoca el caso de uso [I wish reward](?name=UC-PTF-RW011)
3. Fin de flujo

##### 7. El member quiere visualizar el detalle de un reward (paso 11 del flujo basico)

1. El member clickea el campo del reward que es link 
2. El sistema evalua los campos Detail View y Detail Page 
3. El sistema muestra la pagina relacionada como Detail Page en el formato acorde a la siguiente [configuracion](?name=UC-PTF-FE010)
4. Fin de flujo

##### 8. El member quiere ordenar el catalogo de por distintos campos (paso 6 del flujo basico)

1. El sistema evalua que campo del fieldset del componente tiene el valor ASCENDING o DESCENDING en el picklist Order by y muestra en el frontend un picklist de seleccion con dichos campos
2. El member clickea el picklist de seleccion de campos y selecciona un campo distinto al default.
3.El sistema reordena los rewards del componente catalogo de acuerdo al campo y opcion (ascendente o descendente) elegida por el member.
4. Fin de flujo.

##### 9. El member quiere navegar a la siguiente pagina del catalogo (paso 7 del flujo basico)

1. El sistema evalua que el componente tiene marcado el checkbox Paging
2. El sistema muestra la cantidad de items seteada en el campo Items per page por pagina y los links Next y Previous para permitir al member navegar por las paginas.
3. El member clickea el link Next 
2. El sistema invoca la [API Reward Data](?name=UC-PTF-RW099) pasando como parametros el program del site, los campos del fieldset y el offset (posicion de la base de datos) a partir de donde tiene que retornar la informacion. 
3. 10. El sistema muestra el link Previous (grisado porque es la primer pagina) y el link Next. Y en cada pagina muestra la cantidad de rewards de acuerdo a lo ingresado en el campo Items per Page del componente catalog. 
3. Fin de flujo.

##### 10. El member quiere navegar a la pagina anterior del catalogo (paso 7 del flujo basico)

1. El member clickea el link Previous 
2. El sistema muestra la pagina anterior del componente catalogo 
3. Fin de flujo.



