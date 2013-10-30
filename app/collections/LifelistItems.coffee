Collection = require('./supers/Collection')


module.exports = class LifelistItems extends Collection

  url: Collection.serverUrl('lifelist_items')

  model: (attrs, options) ->
    LifelistItem = require('models/LifelistItem')
    return LifelistItem.create(attrs, options)