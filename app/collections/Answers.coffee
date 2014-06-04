@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
 # Collection = Collections.Supers.Collection

  class Collections.Answers extends Collections.Supers.Collection

    url: ->
      Collections.Supers.Collection.serverUrl('mentee_profiles') + '/' + @owner.id + '/answers'

    model: (attrs, options) ->
      return App.Models.Answer.create(attrs, options)