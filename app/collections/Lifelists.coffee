Collection = require('./supers/Collection')


module.exports = class Lifelists extends Collection

  url: Collection.serverUrl('lifelists')

  model: (attrs, options) ->
    Lifelist = require('models/Lifelist')
    return Lifelist.create(attrs, options)