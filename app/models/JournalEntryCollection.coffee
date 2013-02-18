Collection = require('./supers/Collection')
JournalEntry= require('./JournalEntry')

module.exports = class JournalEntryCollection extends Collection

  model: JournalEntry
  url: ->
    Collection.serverUrl('mentees')() + '/' + @mentee_id + '/journal_entries'
  
  initialize: (attrs) ->
    #@storage = new Offline.Storage('mentees', this)
    @mentee_id = attrs.mentee_id
    super