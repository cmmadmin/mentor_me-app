@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.Lifelist extends Model
    urlRoot: Collection.serverUrl('lifelists')
  
  App.on "initialize:before", ->
    # Supermodel definitions
    Models.Lifelist.has().one('edition', 
      model: Models.Edition
      inverse: 'lifelist'
    )

    Models.Lifelist.has().many('lifelist_items', 
      collection: App.Collections.LifelistItems
      inverse: 'lifelist'
    )