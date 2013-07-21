SuperCollection = require('./supers/SuperCollection')
Mentee = require('models/Mentee')

module.exports = class Mentees extends SuperCollection

  model: Mentee
  url: SuperCollection.serverUrl('mentees')
  
  initialize: ->
    #@storage = new Offline.Storage('mentees', this)
    super