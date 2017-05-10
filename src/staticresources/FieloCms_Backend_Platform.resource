var QueryString = function () {
  // This function is anonymous, is executed immediately and 
  // the return value is assigned to QueryString!
  var query_string = {};
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
        // If first entry with this name
    if (typeof query_string[pair[0]] === "undefined") {
      query_string[pair[0]] = decodeURIComponent(pair[1]);
        // If second entry with this name
    } else if (typeof query_string[pair[0]] === "string") {
      var arr = [ query_string[pair[0]],decodeURIComponent(pair[1]) ];
      query_string[pair[0]] = arr;
        // If third or later entry with this name
    } else {
      query_string[pair[0]].push(decodeURIComponent(pair[1]));
    }
  } 
  return query_string;
}();

(function() {
  'use strict';

  /**
   * @description Controlador para la MetaSegment
   * Implementa los patrones de diseño definidos por MDL en
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Hugo Gómez Mac Gregor <hugo.gomez@fielo.com>
   * @param {HTMLElement} element - Elemento que será mejorado.
   * @constructor
   */
  var MetaSegment = function MetaSegment(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.MetaSegment = MetaSegment;

  /**
   * Guarda strings para nombres de clases definidas por este componente que son 
   * usadas por JavaScript.
   * Esto nos permite cambiarlos solo en un lugar
   * @enum {string}
   * @private
   */
  MetaSegment.prototype.CssClasses_ = {};

   /**
   * Inicializa el elemento
   */
  MetaSegment.prototype.init = function() {
    if (this.element_) {
      this.element_.innerHTML = 'Label.Multisegmentss';

      var url = document.getElementById('tsid-menuItems') || '';
      if (url !== '') {
     	  url = url.querySelector('a[href*="salesforce.com/home/home.jsp"]')
     	  	.getAttribute('href');
     	  if (url.indexOf("://") > -1) {
        	url =  url.split('/')[0] + '//' + url.split('/')[2];
		    } else {
	        url = 'https://' + url.split('/')[0];
		    }
      } 
      
   	  url = url + '/apex/segmentselection?id=' + QueryString.id;

     	this.element_.setAttribute('href', url);
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({
    constructor: MetaSegment,
    classAsString: 'MetaSegment',
    cssClass: 'fielosf-meta-segment',
    widget: false
  });
})();

document.addEventListener("DOMContentLoaded", function() {
	var addSegmentLogic = document.querySelectorAll(
		'.fielosf-media-create,' +
		'.fielosf-post-create,' +
		'.fielosf-navigation-create'
		);
	if (addSegmentLogic.length == 1) {
		var segmentButton = document.createElement('a');
		segmentButton.classList.add('slds-button');
		segmentButton.classList.add('slds-button--neutral');
		segmentButton.classList.add('fielosf-meta-segment');

		var actions = document.querySelector(
			'.fielosf-header > .slds-grid > '+
			'.slds-col:nth-child(2) .slds-button-group:nth-child(1)'
		);
		actions.insertBefore(segmentButton, actions.children[0]);
	}
});