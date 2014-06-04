@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class Collections.Mentees extends Collection

    url: Collection.serverUrl('mentees')

    initialize: ->
      #@storage = new Offline.Storage('mentees', this)
      super

    model: (attrs, options) ->
      Mentee = require('models/Mentee')
      return Mentee.create(attrs, options)

    comparator: (mentee) ->
      return mentee.get('name')