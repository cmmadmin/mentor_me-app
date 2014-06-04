@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class Collections.LifelistCategories extends Collection

    url: Collection.serverUrl('lifelist_categories')

    model: (attrs, options) ->
      LifelistCategory = App.Models.LifelistCategory
      return LifelistCategory.create(attrs, options)