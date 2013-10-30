Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class Lifelist extends Model
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