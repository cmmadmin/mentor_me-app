Collection = require('./supers/Collection')


module.exports = class Answers extends Collection

  url: Collection.serverUrl('answers')

  model: (attrs, options) ->
    Answer = require('models/Answer')
    return Answer.create(attrs, options)