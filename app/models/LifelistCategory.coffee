@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.LifelistCategory extends Model
    urlRoot: Collection.serverUrl('lifelist_categories')

    itemsByLifelist: (lifelist) ->
      LifelistItems = App.Collections.LifelistItems
      new LifelistItems(@lifelist_items().where({lifelist_id: lifelist.id}))

  App.on "initialize:before", ->
    Models.LifelistCategory.has().many('lifelist_items', 
      collection: App.Collections.LifelistItems
      inverse: 'lifelist_category'
    )