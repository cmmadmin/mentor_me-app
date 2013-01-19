Collection = require('./supers/Collection')
Mentee = require('./Mentee')

module.exports = class MenteeCollection extends Collection

  model: Mentee
  url: Collection.serverUrl('mentees')
  
  initialize: ->
    #@storage = new Offline.Storage('mentees', this)
    super