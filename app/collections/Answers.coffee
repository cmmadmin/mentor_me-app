Collection = require('./supers/Collection')


module.exports = class Answers extends Collection

  url: ->
    Collection.serverUrl('mentee_profiles') + '/' + @owner.id + '/answers'

  model: (attrs, options) ->
    Answer = require('models/Answer')
    return Answer.create(attrs, options)