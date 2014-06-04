@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class LifelistCategories extends Collection

    url: Collection.serverUrl('lifelist_categories')

    model: (attrs, options) ->
      LifelistCategory = require('models/LifelistCategory')
      return LifelistCategory.create(attrs, options)