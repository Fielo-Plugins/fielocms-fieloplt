(function() {
  'use strict';

  /**
   * @description Constructor for the add to cart component.
   * FieloPLTAddToCart Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Alejandro Spinelli <alejandro.spinelli@fielo.com>
   * @author Hugo Gómez Mac Gregor <hugo.gomez@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloPLTAddToCart = function FieloPLTAddToCart(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloPLTAddToCart = FieloPLTAddToCart;

  // Properties

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloPLTAddToCart.prototype.CssClasses_ = {
    ADD: 'fieloplt-add-to-cart__submit',
    QUANTITY: 'fieloplt-add-to-cart__quantity'
  };

  // Private methods

  /**
   * Set Defaults settings
   *
   * @private
   */
  FieloPLTAddToCart.prototype.setDefaults_ = function() {
    this.add_ = this.element_.getElementsByClassName(this.CssClasses_.ADD)[0];
    this.quantity_ =
        this.element_.getElementsByClassName(this.CssClasses_.QUANTITY)[0];
    this.rewardId_ = this.element_.dataset.rewardId;
    this.success_ = this.element_.dataset.labelSuccess;
  };

   /**
   * add items to cart
   *
   * @private
   */
  FieloPLTAddToCart.prototype.addItemToCart_ = function() {
    var jsonShop = {};
    var shopCookie = fieloUtils.getCookie("apex__shoppingCart");
    if(shopCookie != undefined && shopCookie != ""){
        jsonShop = JSON.parse(shopCookie);
        if(jsonShop[this.rewardId_] != undefined){
          jsonShop[this.rewardId_] += parseInt(this.quantity_.value);
        }else{
          jsonShop[this.rewardId_] = parseInt(this.quantity_.value);
        }
    }else{
        jsonShop[this.rewardId_] = parseInt(this.quantity_.value);
    }
    fieloUtils.setCookie("apex__shoppingCart", JSON.stringify(jsonShop), 1);

    fieloUtils.message.FieloMessage.clear();
    fieloUtils.message.FieloMessage.addMessages(this.success_);
    fieloUtils.message.FieloMessage.setRedirect('#', 3);
    fieloUtils.message.FieloMessage.show();
  };

  /**
   * Sets listeners
   *
   * @private
   */
  FieloPLTAddToCart.prototype.addEventListeners_ = function() {
    this.add_.addEventListener('click', this.addClickHandler_.bind(this));
  };

  /**
   * Even handler for the add button
   *
   * @private
   */
  FieloPLTAddToCart.prototype.addClickHandler_ = function() {
    event.stopPropagation();
    this.addItemToCart_();
  };

  // Public methods

  /**
   * Inicializa el elemento
   */
  FieloPLTAddToCart.prototype.init = function() {
    if (this.element_) {
      this.setDefaults_();
      this.addEventListeners_();
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({
    constructor: FieloPLTAddToCart,
    classAsString: 'FieloPLTAddToCart',
    cssClass: 'fieloplt-add-to-cart',
    widget: true
  });
})();


(function() {
  'use strict';

  /**
   * @description Constructor for the add to cart component.
   * FieloPLTShoppingCart Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Alejandro Spinelli <alejandro.spinelli@fielo.com>
   * @author Hugo Gómez Mac Gregor <hugo.gomez@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloPLTShoppingCart = function FieloPLTShoppingCart(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloPLTShoppingCart = FieloPLTShoppingCart;

  // Properties

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloPLTShoppingCart.prototype.CssClasses_ = {
    SAVE: 'fielo-button__save',
    DELETE: 'fielo-button__delete',
    EMPTY: 'fielo-button__empty-cart',
    RECORD: 'fielo-record',
    QUANTITY: 'fieloplt-shopping-cart__quantity'
  };

  // Private methods

  /**
   * Set Defaults settings
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.setDefaults_ = function() {
    this.save_ =
      this.element_.getElementsByClassName(this.CssClasses_.SAVE)[0];
    this.deleteButtons_ =
      this.element_.getElementsByClassName(this.CssClasses_.DELETE);
    this.empty_ =
      this.element_.getElementsByClassName(this.CssClasses_.EMPTY)[0];
    this.success_ = this.element_.dataset.labelSuccess;
  };

  /**
   * add items to cart
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.saveCart_ = function(){
    var jsonShop = {};
    var quantities_ =
      this.element_.getElementsByClassName(this.CssClasses_.QUANTITY);
    for(var i = 0; i < quantities_.length; i++){
      jsonShop[quantities_[i].name.split("quantities.")[1]] = parseInt(quantities_[i].value);
    }
    quantities_ = null;
    fieloUtils.setCookie("apex__shoppingCart", JSON.stringify(jsonShop), 1);
    fieloUtils.message.FieloMessage.clear();
    fieloUtils.message.FieloMessage.addMessages(this.success_);
    fieloUtils.message.FieloMessage.setRedirect('#', 3);
    fieloUtils.message.FieloMessage.show();
  };

  /**
   * Sets listeners
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.addEventListeners_ = function() {
    this.save_.addEventListener('click', this.saveClickHandler_.bind(this));
    [].forEach.call(this.deleteButtons_, function(button){
      button.addEventListener('click', this.deleteClickHandler_.bind(this));
    }, this);
    this.empty_.addEventListener('click', this.emptyClickHandler_.bind(this));
  };

  /**
   * Even handler for the save button
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.saveClickHandler_ = function() {
    event.stopPropagation();
    this.saveCart_();
  };

  /**
   * Even handler for the delete button
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.deleteClickHandler_ = function(click) {
    event.stopPropagation();
    this.deleteItem_(click);
  };

  /**
   * Even handler for the empty button
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.emptyClickHandler_ = function(click) {
    event.stopPropagation();
    this.emptyCart_(click);
  };


  /**
   * delete item
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.deleteItem_ = function(click){
   if (confirm(fieloUtils.site.FieloSite.getLabel('areYouSure'))) {
      var record =
      fieloUtils.getParentUntil(click.target, '.' + this.CssClasses_.RECORD);
      record.parentElement.removeChild(record);
      record = null;
      this.save_.click();
    }
  };

  /**
   * Empty cart
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.emptyCart_ = function(click){
    if (confirm(fieloUtils.site.FieloSite.getLabel('areYouSure'))) {
      fieloUtils.setCookie("apex__shoppingCart", "", -1);
      oldLoader.components.refreshView(this.element_);
    }
  };



  // Public methods

  /**
   * Inicializa el elemento
   */
  FieloPLTShoppingCart.prototype.init = function() {
    if (this.element_) {
      this.setDefaults_();
      this.addEventListeners_();
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({
    constructor: FieloPLTShoppingCart,
    classAsString: 'FieloPLTShoppingCart',
    cssClass: 'fieloplt-shopping-cart',
    widget: true
  });
})();


function FieloPLTcheckDeleteCookie(result, event){
    // Coloco los mensajes de error o de exito segun corresponda
    if (event.status && result !== undefined) {
      var error = false;
      // Si existen mensajes verifico si hay alguno de error
      // y seteo el flag error a true
      if (typeof result.messages !== 'undefined') {
        for (
          var index = 0, maximun = result.messages.length;
          index < maximun;
          index++
        ) {
          if (
            result.messages[index]
              .severity.toLowerCase() === 'ERROR'.toLowerCase() ||
            result.messages[index]
              .severity.toLowerCase() === 'FATAL'.toLowerCase()
          ) {
            error = true;
            break;
          }
        }
      }

      if(!error){
        fieloUtils.setCookie("apex__shoppingCart", "", -1);
      }
    }
}




(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloPLTLogin Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Alejandro Spinelli <alejandro.spinelli@fielo.com>
   * @author Hugo Gómez Mac Gregor <hugo.gomez@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloPLTLogin = function FieloPLTLogin(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloPLTLogin = FieloPLTLogin;

  // Properties

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloPLTLogin.prototype.CssClasses_ = {
    SUBMIT: 'fieloplt-login__submit'
  };

  // Private methods

  /**
   * Set Defaults settings
   *
   * @private
   */
  FieloPLTLogin.prototype.setDefaults_ = function() {
    this.submit_ =
      this.element_.getElementsByClassName(this.CssClasses_.SUBMIT)[0];
  };

  /**
   * Sets listeners
   *
   * @private
   */
  FieloPLTLogin.prototype.addEventListeners_ = function() {
    this.submit_.addEventListener('click', this.submitClickHandler_.bind(this));
  };

  /**
   * Even handler for the save button
   *
   * @private
   */
  FieloPLTLogin.prototype.submitClickHandler_ = function() {
    fieloUtils.setCookie('apex__shoppingCart', '', -1);
  };

  // Public methods

  /**
   * Inicializa el elemento
   */
  FieloPLTLogin.prototype.init = function() {
    if (this.element_) {
      this.setDefaults_();
      this.addEventListeners_();
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({
    constructor: FieloPLTLogin,
    classAsString: 'FieloPLTLogin',
    cssClass: 'fieloplt-login',
    widget: true
  });
})();