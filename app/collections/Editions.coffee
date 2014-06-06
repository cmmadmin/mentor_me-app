@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection
  Edition = App.Models.Edition

  class Collections.Editions extends Collection

    url: Collection.serverUrl('editions')

    model: (attrs, options) ->
      return Edition.create(attrs, options)