## Add Reward from Catalog
#### Objetivo

El presente caso de uso describe como el member agrega rewards en el shopping cart en el site

#### Precondiciones

El member tiene que estar logueado al site. 

Existen rewards creados para el program.

Existe una page con un componente catalog asociado a una navigation visible para el member. 

En el [fieldset del componente](?name=UC-PTF-FE006) esta configurado de la siguiente forma,

- Subcomponente Add to cart

El member tiene saldo de puntos mayor o igual a los puntos del reward que quiere agregar.

Existe una page con un componente Shopping Cart asociado a una navigation visible para el member. 

#### Postcondiciones

Rewards agregados al shopping cart.

#### Flujo de Eventos

#### Flujo Básico

1. El member accede a la navigation que muestra la page con el componente catalog
2. El member selecciona la cantidad de items del reward que quiere agregar al shopping cart
3. El member presiona el boton Add to cart
3. El sistema valida que el reward no tenga segments o que el member aplique al menos a uno de los segments del reward
4. El sistema valida que los items availables del reward sea igual o mayor a la cantidad de items seleccionada
5. El sistema valida que el member tenga un saldo de puntos mayor a los puntos del reward
6. El sistema valida que existe una redemption con estado open y origin frontend para el member
7. El sistema valida que en el program al que esta relacionado el member tiene marcada la opcion Shopping Cart 
8. El sistema crea un redemption item relacionado a la redemption invocando el caso de uso [Add Redemption Item](?name=UC-PTF-RW012)
9. El sistema muestra el mensaje "Reward Added Succesfully"
10. El sistema oculta en el componente Catalog para el reward agregado el input de cantidad de items y el boton Add reward y muestra el mensaje "This reward is already in your shopping cart, please modify the quantity in the shopping cart."
11. Fin de flujo.
      
#### Flujos Alternativos

##### 1. El member no cumple con ninguno de los segments relacionados al rewards (paso 3 del flujo basico)
1. El sistema valida que el reward tiene segments y que el member no cumple con ninguno
2. El sistema muestra el mensaje de error: The reward cannot be added. Does not adhere to segments of the reward.
3. Fin de flujo.

##### 2. El reward tiene 0 items available y stock management Unlimited (paso 4 del flujo basico)
1. El sistema valida que el reward tiene 0 items available y que el stock management es unlimited.
2. Continua en el paso 5 del flujo basico porque los rewards con stock management Unlimited no controlan stock.

##### 3. El reward tiene menos items available que lo ingresado y stock management distinto de Unlimited (paso 4 del flujo basico)
1. El sistema valida que el reward no tiene suficientes items disponibles y el stock management es distinto de unlimited
2. El sistema muestra el mensaje de error: Insufficient Inventory
3. Fin de flujo

##### 4. El member no tiene saldo de puntos suficientes (paso 5 del flujo basico)
1. El sistema valida que el member tiene un saldo de puntos menor a la cantidad de puntos para canjear los items seleccionados del reward 
2. El sistema muestra el mensaje de error: Insufficient Points
3. Fin de flujo

##### 5. El sistema valida que no existe ninguna redemption con status open y origin frontend para el member  (paso 6 del flujo basico)
1. El sistema valida que no existe redemption con status open y origin frontend para el member
2. El sistema crea una redemption con status open y origin frontend para el member 
3. Continua en el paso 7 del flujo basico.

##### 6. El program no usa Shopping cart (paso 7 del flujo basico)
1. El sistema verifica que el campo Shopping Cart en el program del member esta desmarcado
2. El sistema invoca el caso de uso [Checkout](?name=UC-PTF-RW013)
3. Fin de flujo

##### 7. El reward ya esta en el Shopping Cart (paso 5 del flujo basico)
1. El sistema valida que el reward ya se encuentra en el shopping cart
2. El sistema muestra un mensaje de error: "This reward is already in your shopping cart, please modify the quantity in the shopping cart." 
3. Fin de flujo






