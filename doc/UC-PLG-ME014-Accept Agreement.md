## Accept Agreement

### Objetivo

El presente caso de uso describe la accion de aceptar el agreement por parte del memberfuncionalidad del componente agreement

### Precondiciones

- Existe un componente agreement configurado en una page o en el template del site al que esta accediendo el member.
- Existe un agreement con status Current.
- El member no esta relacionado a un agreement

### Postcondiciones

El member acepta el agreement y queda relacionado al mismo.
Flujo de Eventos

### Flujo Basico

1. El sistema valida que existe un agreement con status current para el program del member logueado
2. El sistema valida que el member logueado no esta relacionado al agreement con status current
3. El sistema muestra el agreement current con la opcion de visualizarlo en PDF y la opcion "I agree"
4. El member presiona el boton "I Agree"
5. El sistema relaciona el member al agreement que acaba de aceptar. 
6. Fin de flujo


### Flujos Alternativos

#### 1. El sistema valida que el agreement relacionado al member esta deprecado (paso 2 del flujo basico)

1 . El sistema valida que el member esta relacionado a un agreement deprecado
2. Continua en el paso 3 del flujo basico.
