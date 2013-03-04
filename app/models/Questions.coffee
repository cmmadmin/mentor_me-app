Collection = require('./supers/Collection')
Question = require('./Question')

module.exports = class Questions extends Collection

  model: Question
  url: Collection.serverUrl('questions')
  
  initialize: ->
    #@storage = new Offline.Storage('questions', this)
    super