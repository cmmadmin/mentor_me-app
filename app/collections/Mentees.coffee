Collection = require('./supers/Collection')
Mentee = require('models/Mentee')

module.exports = class Mentees extends Collection

  model: Mentee
  url: Collection.serverUrl('mentees')
  
  initialize: ->
    #@storage = new Offline.Storage('mentees', this)
    super