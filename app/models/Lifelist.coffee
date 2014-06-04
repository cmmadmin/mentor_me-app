@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.Lifelist extends Model
    urlRoot: Collection.serverUrl('lifelists')

  # Put at bottom to avoid circular dependency (ugly commonjs exports hack)
  Edition = require('./Edition')
  LifelistItems = require('collections/LifelistItems')

  # Supermodel definitions
  Lifelist.has().one('edition', 
    model: Edition
    inverse: 'lifelist'
  )

  Lifelist.has().many('lifelist_items', 
    collection: LifelistItems
    inverse: 'lifelist'
  )