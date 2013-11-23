Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class LifelistCategory extends Model
  urlRoot: Collection.serverUrl('lifelist_categories')

  itemsByLifelist: (lifelist) ->
    LifelistItems = require('collections/LifelistItems')
    new LifelistItems(@lifelist_items().where({lifelist_id: lifelist.id}))
  
# Put at bottom to avoid circular dependency (ugly commonjs exports hack)
LifelistItems = require('collections/LifelistItems')

LifelistCategory.has().many('lifelist_items', 
  collection: LifelistItems
  inverse: 'lifelist_category'
)