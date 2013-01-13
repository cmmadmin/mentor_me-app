###
 * Base Class for all Backbone Collections
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

ApplicationConfig = require('config/ApplicationConfig')

module.exports = class Collection extends Backbone.Collection

  ###//--------------------------------------
  //+ PUBLIC PROPERTIES / CONSTANTS
  //--------------------------------------###

  ###//--------------------------------------
  //+ INHERITED / OVERRIDES
  //--------------------------------------###
  fetch: ->
    @trigger('fetch')
    super

  ###//--------------------------------------
  //+ PUBLIC METHODS / GETTERS / SETTERS
  //--------------------------------------###

  ###
  Get model by id if it exists, or fetch and add if not
  ###
  getOrFetch: (id) ->
    model = @get(id)
    if !model?
      model = new @model(id: id)
      @add model
      model.fetch()
    return model

  ###
  Get or add model by id, and then force fetch
  ###
  getAndFetch: (id) ->
    model = @push(id: id)
    model.fetch()
    return model

  ###//--------------------------------------
  //+ EVENT HANDLERS
  //--------------------------------------###

  ###//--------------------------------------
  //+ PRIVATE AND PROTECTED METHODS
  //--------------------------------------###

  ###//--------------------------------------
  //+ STATIC METHODS
  //--------------------------------------###
  @serverUrl: (url) ->
    return ->
      return ApplicationConfig.SERVER_URL + url
      