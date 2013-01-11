Collection = require('./supers/Collection')
Mentee = require('./Mentee')

module.exports = class MenteeCollection extends Collection

  model: Mentee
  url: Collection.serverUrl('mentees')
  
  initialize: ->
    super