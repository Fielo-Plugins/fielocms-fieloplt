## My Account
### Objetivos

El presente caso de uso describe la modificacion de los datos del member realizada por el mismo member desde el site.

### Precondiciones

El member tiene que estar logueado en el site
El componente Account tiene que estar agregado en una page asociada a una navigation visible para el member

### Postcondiciones

El perfil del member fue actualizado.

### Flujo de Eventos

### Flujo Basico

1. El member se loguea en el site del program al que pertenece
2. El member accede a la page que contenga el componente Account
3. El sistema despliega los datos del member y subcomponentes seleccionados en el fieldset del componente Account y el boton Edit.
4. El member presiona el boton Edit
5. El sistema muestra los datos del member seleccionados en el fiedset del componente en modo edicion. Los botones Save y Cancel
6. El member edita sus datos.
7. El member presiona el boton Save.
8. El sistema recalcula el porcentaje del perfil completado.
9. El sistema redirecciona al detalle del profile del member mostrando los datos actualizados.
10. El perfil del member fue actualizado exitosamente.

### Flujos Alternativos

#### 1. El member no completa los campos obligatorios (paso 6 del flujo basico)

1. El sistema verifica que el member no completo todos los datos obligatorios.
2. El sistema muestra un mensaje de error.
3. El sistema muestra la pantalla de edicion del profile con los valores originales. 
4. Continua en el paso 6 del flujo basico

#### 2. El member completa los campos con formato invalido (paso 6 del flujo basico)

1. El sistema verifica que el member completo los campos con formatos invalidos.
2. El sistema muestra un mensaje de error.
3. El sistema muestra la pantalla de edicion del profile con los valores originales. 
4. Continua en el paso 6 del flujo basico

#### 3. El subcomponente Image se encuentra dentro del fieldset del componente Account y el member sube una imagen (paso 3 del flujo basico)

1. El member presiona el boton browse.
2. El sistema abre una ventana de seleccion de archivo.
3. El member selecciona una archivo .jpg, .gif o png
4. El sistema valida que la imagen sea .jpg, .gif or .png.
5. El sistema cambia la imagen del member por la recien seleccionada.
6. El member presiona el boton Upload
7. Continua en el paso 8 del flujo basico


#### 4. El subcomponente Image se encuentra dentro del fieldset del componente Account y el member sube un archivo que no es imagen (paso 3 del flujo basico)

1. El member presiona el boton browse.
2. El sistema abre una ventana de seleccion de archivo.
3. El member selecciona una archivo que no sea .jpg, .gif o .png 
4. El sistema valida que el archivo no es valido
5. El sistema no habilita el boton Upload
6. Fin de flujo

#### 4. El member presiona el boton Cancel (Paso 14 del flujo basico)

1. El sistema muestra la pantalla de detalle de profile sin cambios.
2. Fin de flujo.

