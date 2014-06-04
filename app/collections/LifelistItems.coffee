@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class LifelistItems extends Collection

    url: Collection.serverUrl('lifelist_items')

    model: (attrs, options) ->
      LifelistItem = require('models/LifelistItem')
      return LifelistItem.create(attrs, options)
    comparator: (item) ->
      item.get('title')