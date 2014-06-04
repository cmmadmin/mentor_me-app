@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
#  Collection = Collections.Supers.Collection

  class Collections.Answers extends Collections.Supers.Collection

    url: ->
      Collection.serverUrl('mentee_profiles') + '/' + @owner.id + '/answers'

    model: (attrs, options) ->
      Answer = require('models/Answer')
      return Answer.create(attrs, options)