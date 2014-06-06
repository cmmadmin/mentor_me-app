@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class Collections.Lifelists extends Collection

    url: Collection.serverUrl('lifelists')

    model: (attrs, options) ->
      Lifelist = App.Models.Lifelist
      return Lifelist.create(attrs, options)