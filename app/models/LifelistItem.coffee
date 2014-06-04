@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.LifelistItem extends Model
    urlRoot: Collection.serverUrl('lifelist_items')

  App.on "initialize:before", ->
    # Supermodel definitions
    Models.LifelistItem.has().one('lifelist', 
      model: Models.Lifelist
      inverse: 'lifelist_items'
    )

    Models.LifelistItem.has().one('lifelist_category', 
      model: Models.LifelistCategory
      inverse: 'lifelist_items'
    )