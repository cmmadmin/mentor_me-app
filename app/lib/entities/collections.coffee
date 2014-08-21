@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Collection extends Backbone.Collection
    fetch: ->
      @trigger('fetch')
      super(silent: false)

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
      model = @get(id)
      if !model?
        model = new @model(id: id)
        @add model
      model.fetch()
      return model

    getChosenModels: ->
      @filter (m) ->
        m.get('chosen')
    getChosenIds: ->
      @getChosenModels().map (m) ->
        m.id
      
    ###//--------------------------------------
    //+ STATIC METHODS
    //--------------------------------------###
    @serverUrl: (url) ->
      return App.Config.ApplicationConfig.SERVER_URL + url
      