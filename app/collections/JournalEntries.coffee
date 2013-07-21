SuperCollection = require('./supers/SuperCollection')
JournalEntry= require('models/JournalEntry')

module.exports = class JournalEntryCollection extends SuperCollection

  model: JournalEntry
  url: ->
    SuperCollection.serverUrl('mentees')() + '/' + @mentee_id + '/journal_entries'
  
  initialize: (attrs) ->
    #@storage = new Offline.Storage('mentees', this)
    @mentee_id = attrs.mentee_id
    super