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
   * Guarda strings para nombres de clases definidas por este componente que son usadas por JavaScript.
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
     alert('meta segment init');
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
	var segmentButton = $('<div/>').html(
		'<button class="slds-button slds-button--neutral fielosf-meta-segment">Label.MultiSegment' +
		'</button>'
	);
	if (addSegmentLogic.length == 1) {
		$(
			'.fielosf-header > .slds-grid > '+
			'.slds-col:nth-child(2) .slds-button-group:nth-child(1)'
		).prepend(segmentButton.html());
	}
});