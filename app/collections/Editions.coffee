Collection = require('./supers/Collection')
Edition = require('models/Edition')

module.exports = class Editions extends Collection

  url: Collection.serverUrl('editions')

  model: (attrs, options) ->
    return Edition.create(attrs, options)