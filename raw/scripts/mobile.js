(function() {
  'use strict';

  /**
   * @description Constructor for the add to cart component.
   * FieloPLTCart Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Alejandro Spinelli <alejandro.spinelli@fielo.com>
   * @author Hugo Gómez Mac Gregor <hugo.gomez@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloPLTCart = function FieloPLTCart(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloPLTCart = FieloPLTCart;

  // Properties

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloPLTCart.prototype.CssClasses_ = {
    ADD: 'fieloplt-add-to-cart__submit',
    QUANTITY: 'fieloplt-add-to-cart__quantity'
  };

  // Private methods

  /**
   * Set Defaults settings
   *
   * @private
   */
  FieloPLTCart.prototype.setDefaults_ = function() {
    this.add_ = this.element_.getElementsByClassName(this.CssClasses_.ADD)[0];
    this.quantity_ =
        this.element_.getElementsByClassName(this.CssClasses_.QUANTITY)[0];
    this.rewardId_ = this.element_.dataset.rewardId;
    this.success_ = this.element_.dataset.labelSuccess;
  };

  /**
   * gets a coockie
   *
   * @private
   */
  FieloPLTCart.prototype.getCookie_ = function(name) {
    var name = name + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
  };


/**
   * sets a coockie
   *
   * @private
   */
  FieloPLTCart.prototype.setCookie_ = function(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
  };

  /**
   * add items to cart
   *
   * @private
   */
  FieloPLTCart.prototype.addItemToCart_ = function() {
    var jsonShop = {};
    var shopCookie = this.getCookie_("apex__shoppingCart");
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
    this.setCookie_("apex__shoppingCart", JSON.stringify(jsonShop), 1);

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
  FieloPLTCart.prototype.addEventListeners_ = function() {
    this.add_.addEventListener('click', this.addClickHandler_.bind(this));
  };

  /**
   * Even handler for the add button
   *
   * @private
   */
  FieloPLTCart.prototype.addClickHandler_ = function() {
    event.stopPropagation();
    this.addItemToCart_();
  };

  // Public methods

  /**
   * Inicializa el elemento
   */
  FieloPLTCart.prototype.init = function() {
    if (this.element_) {
      this.setDefaults_();
      this.addEventListeners_();
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({
    constructor: FieloPLTCart,
    classAsString: 'FieloPLTCart',
    cssClass: 'fieloplt-add-to-cart',
    widget: true
  });
})();