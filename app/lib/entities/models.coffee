@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Model extends Supermodel.Model

    status: 0

    destroy: (options = {}) ->
      _.defaults options,
        wait: true

      @set _destroy: true
      super options

    isDestroyed: ->
      @get "_destroy"


    fetch: ->
      @trigger('fetch', @)
      super

    save: (data, options = {}) ->
      isNew = @isNew()

      _.defaults options,
        wait: true
        success:   _.bind(@saveSuccess, @, isNew, options.collection, options.callback)
        error:    _.bind(@saveError, @)

      @unset "_errors"
      super data, options

    saveSuccess: (isNew, collection, callback) =>
      if isNew ## model is being created
        collection?.add @
        collection?.trigger "model:created", @
        @trigger "created", @
      else ## model is being updated
        collection ?= @collection ## if model has collection property defined, use that if no collection option exists
        collection?.trigger "model:updated", @
        @trigger "updated", @

      callback?()

    saveError: (model, xhr, options) =>
      ## set errors directly on the model unless status returned was 500 or 404
      @set _errors: $.parseJSON(xhr.responseText)?.errors unless /500|404/.test xhr.status

    sync: (method, model, options) ->
      options = options || {};
      # Use collection url if creating instead of default shallow url
      if (method.toLowerCase() == 'create' && model.collection?)
        options.url = model.collection.url()

      super(method, model, options);