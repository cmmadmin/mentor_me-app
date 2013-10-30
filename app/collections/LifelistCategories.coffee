Collection = require('./supers/Collection')


module.exports = class LifelistCategories extends Collection

  url: Collection.serverUrl('lifelist_categories')

  model: (attrs, options) ->
    LifelistCategory = require('models/LifelistCategory')
    return LifelistCategory.create(attrs, options)