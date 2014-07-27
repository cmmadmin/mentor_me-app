@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.JournalEntry extends Entities.Model
    urlRoot: ->
      Entities.Collection.serverUrl('journal_entries')

    initialize: ->
      if !@has('logged_at')
        currDate = new Date().now()
        @set('logged_at', currDate)


  class Entities.JournalEntryCollection extends Entities.Collection
    model: Entities.JournalEntry
    url: ->
      Entities.Collection.serverUrl('mentees') + '/' + @owner.id + '/journal_entries'


  Entities.on "before:start", ->
    Entities.JournalEntry.has().one('mentee', 
      model: App.Models.Mentee
      inverse: 'journal_entries'
    )

  API = 
    getJournalEntries: (mentee) ->
      journalEntries = mentee.journal_entries()
      journalEntries.fetch
        reset: true
      journalEntries

    getJournalEntry: (id) ->
      journalEntry = App.Entities.JournalEntry._all.get(id)
      journalEntry

  App.reqres.setHandler "journal:entities", (mentee) ->
    API.getJournalEntries mentee

  App.reqres.setHandler "journal:entity", (id) ->
    API.getJournalEntry id

  # App.reqres.setHandler "new:journal:entity", ->
  #   API.newJournalEntry()