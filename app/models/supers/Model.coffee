###
 * Base Class for all Backbone Models
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM.module "Models.Supers", (Supers, App, Backbone, Marionette, $, _) ->
  
  class Supers.Model extends Supermodel.Model

    ###//--------------------------------------
    //+ PUBLIC PROPERTIES / CONSTANTS
    //--------------------------------------###
    status: 0

    fetch: ->
      @trigger('fetch', @)
      super

    sync: (method, model, options) ->
      options = options || {};
      # Use collection url if creating instead of default shallow url
      if (method.toLowerCase() == 'create' && model.collection?)
        options.url = model.collection.url()

      super(method, model, options);
