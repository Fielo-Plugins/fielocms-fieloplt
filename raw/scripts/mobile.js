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
        jsonShop = JSON.parse(shopCookie.replace(/[']/g, "\""));
        if(jsonShop[this.rewardId_] != undefined){
          jsonShop[this.rewardId_] += parseInt(this.quantity_.value);
        }else{
          jsonShop[this.rewardId_] = parseInt(this.quantity_.value);
        }
    }else{
        jsonShop[this.rewardId_] = parseInt(this.quantity_.value);
    }
    fieloUtils.setCookie("apex__shoppingCart", JSON.stringify(jsonShop).replace(/["]/g, "'"), 1);
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
    POINTS: 'fielo-field--is-FieloPLT__Points__c',
    FIELD_VALUE: 'fielo-field__value',
    PARTIAL_TOTAL: 'fieloplt-shopping-cart__total',
    TOTAL_POINTS: 'fieloplt-shopping-cart__total-points',
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
    this.quantities_ =
      this.element_.getElementsByClassName(this.CssClasses_.QUANTITY);
    this.deleteButtons_ =
      this.element_.getElementsByClassName(this.CssClasses_.DELETE);
    this.partialTotals_ = 
      this.element_.getElementsByClassName(this.CssClasses_.PARTIAL_TOTAL);
    this.totalPoints_ = this.element_.querySelector(
      '.' + this.CssClasses_.TOTAL_POINTS + ' .' + this.CssClasses_.FIELD_VALUE
    );
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
    var quantities =
      this.element_.getElementsByClassName(this.CssClasses_.QUANTITY);
    for(var i = 0; i < quantities.length; i++){
      jsonShop[quantities[i].name.split("quantities.")[1]] = parseInt(quantities[i].value);
    }
    quantities = null;
    fieloUtils.setCookie("apex__shoppingCart", JSON.stringify(jsonShop).replace(/["]/g, "'"), 1);
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
    [].forEach.call(this.quantities_, function(element){
      element.addEventListener(
        'change',
        this.updatePartialPoints_.bind(this, element)
      );
    }, this);

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
    this.updateTotalPoints();
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

  /**
   * Update Partial Points
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.updatePartialPoints_ = function(quantity) {
    var parent =
      fieloUtils.getParentUntil(quantity, '.' + this.CssClasses_.RECORD);
    var partialTotal =
      parent.getElementsByClassName(this.CssClasses_.PARTIAL_TOTAL)[0];
    var points = parent.getElementsByClassName(this.CssClasses_.POINTS)[0];
    points = points.getElementsByClassName(this.CssClasses_.FIELD_VALUE)[0];
    
    partialTotal.innerHTML  = quantity.value * points.innerHTML.replace(',','');
    this.updateTotalPoints();
  };

  /**
   * Update Total Points
   *
   * @private
   */
  FieloPLTShoppingCart.prototype.updateTotalPoints = function() {
    var total = 0;
    [].forEach.call(this.partialTotals_, function(points) {
      total += Number(points.innerHTML.replace(',',''));
    });
    this.totalPoints_.innerHTML = total;
  };



  // Public methods

  /**
   * Inicializa el elemento
   */
  FieloPLTShoppingCart.prototype.init = function() {
    if (this.element_) {
      this.setDefaults_();
      this.addEventListeners_();
      this.updateTotalPoints();
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


(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloPLTRegister Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Nicolas Alejandro Soberon <nicolas.soberon@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloPLTRegister = function FieloPLTRegister(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };

  window.FieloPLTRegister = FieloPLTRegister;

  // Properties

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloPLTRegister.prototype.CssClasses_ = {
    SUBMIT: 'fielo-button__submit'
  };

  // Private methods

  /**
   * Set Defaults settings
   *
   * @private
   */
  FieloPLTRegister.prototype.setDefaults_ = function() {
    this.submit_ =
      this.element_.getElementsByClassName(this.CssClasses_.SUBMIT)[0];    
  };

  /**
   * Sets listeners
   *
   * @private
   */
  FieloPLTRegister.prototype.addEventListeners_ = function() {
    this.submit_.addEventListener('click', this.submitClickHandler_.bind(this));
  };

  /**
   * Even handler for the save button
   *
   * @private
   */
  FieloPLTRegister.prototype.submitClickHandler_ = function(event) {
    fieloUtils.setCookie("apex__shoppingCart", "", -1);          
  };

  // Public methods

  /**
   * Inicializa el elemento
   */
  FieloPLTRegister.prototype.init = function() {
    if (this.element_) {
      this.setDefaults_();
      this.addEventListeners_();
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({
    constructor: FieloPLTRegister,
    classAsString: 'FieloPLTRegister',
    cssClass: 'fieloplt-register',
    widget: true
  });
})();


(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloPLTRegisterS2 Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Nicolas Alejandro Soberon <nicolas.soberon@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloPLTRegisterS2 = function FieloPLTRegisterS2(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };

  window.FieloPLTRegisterS2 = FieloPLTRegisterS2;

  // Properties

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloPLTRegisterS2.prototype.CssClasses_ = {
    SUBMIT: 'fielo-register-step-2__submit',
    PASSWORD: 'password',
    CONFIRM_PASSWORD: 'confirmPassword',
    TYPE_ERROR: 'ERROR'
  };

  // Private methods

  /**
   * Set Defaults settings
   *
   * @private
   */
  FieloPLTRegisterS2.prototype.setDefaults_ = function() {
    this.submit_ =
      this.element_.getElementsByClassName(this.CssClasses_.SUBMIT)[0];
    this.password_ =
      this.element_.getElementsByClassName(this.CssClasses_.PASSWORD)[0];
    this.confirmPassword_ =
      this.element_.getElementsByClassName(this.CssClasses_.CONFIRM_PASSWORD)[0];
    this.errorMsg_ = 'Password does not match confirmation';
  };

  /**
   * Sets listeners
   *
   * @private
   */
  FieloPLTRegisterS2.prototype.addEventListeners_ = function() {
    this.submit_.addEventListener('click', this.submitClickHandler_.bind(this));
  };

  /**
   * Even handler for the save button
   *
   * @private
   */
  FieloPLTRegisterS2.prototype.submitClickHandler_ = function(event) {
    if (this.password_.value !== this.confirmPassword_.value) {
      event.preventDefault();
      fieloUtils.message.FieloMessage.clear();
      fieloUtils.message.FieloMessage.setType(this.CssClasses_.TYPE_ERROR);
      fieloUtils.message.FieloMessage.addMessages(this.errorMsg_);
      fieloUtils.message.FieloMessage.show();
    } else{
      fieloUtils.setCookie("apex__shoppingCart", "", -1);      
    }
  };

  // Public methods

  /**
   * Inicializa el elemento
   */
  FieloPLTRegisterS2.prototype.init = function() {
    if (this.element_) {
      this.setDefaults_();
      this.addEventListeners_();
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({
    constructor: FieloPLTRegisterS2,
    classAsString: 'FieloPLTRegisterS2',
    cssClass: 'fieloplt-register-step-2',
    widget: true
  });
})();


(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloAgreement Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Alejandro Spinelli <alejandro.spinelli@fielo.com>
   * @author Hugo Gómez Mac Gregor <hugo.gomez@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloAgreement = function FieloAgreement(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloAgreement = FieloAgreement;

  // Properties

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloAgreement.prototype.CssClasses_ = {
    AGREE: 'cms-plt-agreement__checkbox',
    HIDE: 'slds-hide',
    SUBMIT: 'fielo-button__submit'
  };

  // Private methods

  /**
   * Set Defaults settings
   *
   * @private
   */
  FieloAgreement.prototype.setDefaults_ = function() {
    this.submit_ =
      this.element_.getElementsByClassName(this.CssClasses_.SUBMIT)[0];
    this.submit_.setAttribute('disabled', 'disabled');
    this.submit_.classList.remove(this.CssClasses_.SUBMIT);
    this.submit_.classList.remove(this.CssClasses_.HIDE);
    this.agree_ =
      this.element_.getElementsByClassName(this.CssClasses_.AGREE)[0];
    fieloUtils.getParentUntil(this.element_, '.mdl-cell').style.zIndex = '99999';
  };

  FieloAgreement.prototype.addEventListeners_ = function() {
    this.agree_.addEventListener('change', function() {
      if (this.agree_.checked) {
      this.submit_.classList.add(this.CssClasses_.SUBMIT);
      this.submit_.removeAttribute('disabled');
    } else {
      this.submit_.classList.remove(this.CssClasses_.SUBMIT);
      this.submit_.setAttribute('disabled', 'disabled');
    }
    }.bind(this));
  };

  // Public methods

  /**
   * Inicializa el elemento
   */
  FieloAgreement.prototype.init = function() {
    if (this.element_) {
      this.setDefaults_();
      this.addEventListeners_();
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({
    constructor: FieloAgreement,
    classAsString: 'FieloAgreement',
    cssClass: 'cms-plt-agreement',
    widget: true
  });
})();