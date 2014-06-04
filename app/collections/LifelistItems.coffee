@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class Collections.LifelistItems extends Collection

    url: Collection.serverUrl('lifelist_items')

    model: (attrs, options) ->
      LifelistItem = App.Models.LifelistItem
      return LifelistItem.create(attrs, options)
    comparator: (item) ->
      item.get('title')