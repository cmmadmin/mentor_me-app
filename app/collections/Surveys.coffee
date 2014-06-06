@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection
  Survey = App.Models.Survey

  class Collections.Surveys extends Collection

    url: ->
      Collection.serverUrl('editions') + '/' + @owner.id + '/surveys'

    model: (attrs, options) ->
      return Survey.create(attrs, options)