SuperCollection = require('./supers/SuperCollection')
Question = require('models/Question')

module.exports = class Questions extends SuperCollection

  model: Question
  url: SuperCollection.serverUrl('questions')
  
  initialize: ->
    #@storage = new Offline.Storage('questions', this)
    super