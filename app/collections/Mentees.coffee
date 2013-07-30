Collection = require('./supers/Collection')


module.exports = class Mentees extends Collection

  url: Collection.serverUrl('mentees')
  
  initialize: ->
    #@storage = new Offline.Storage('mentees', this)
    super

  model: (attrs, options) ->
    Mentee = require('models/Mentee')
    return Mentee.create(attrs, options)

  comparator: (mentee) ->
    return mentee.get('name')