Collection = require('./supers/Collection')
JournalEntry = require('models/JournalEntry')

module.exports = class JournalEntryCollection extends Collection

  url: ->
    Collection.serverUrl('mentees')() + '/' + @mentee_id + '/journal_entries'
  
  initialize: (attrs) ->
    #@storage = new Offline.Storage('mentees', this)
    @mentee_id = attrs.mentee_id
    super

  model: (attrs, options) ->
    return JournalEntry.create(attrs, options)