Collection = require('./supers/Collection')
Survey = require('models/Survey')

module.exports = class Surveys extends Collection

  url: ->
    Collection.serverUrl('editions') + '/' + @owner.id + '/surveys'

  model: (attrs, options) ->
    return Survey.create(attrs, options)