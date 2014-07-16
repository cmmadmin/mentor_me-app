@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.JournalEntry extends Entities.Model

  class Entities.JournalEntryCollection extends Entities.Collection
    model: Entities.JournalEntry
    url: -> Entities.Collection.serverUrl('journal')

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

    # getJournalEntry: (id) ->
    #   journalEntry = new Entities.JournalEntry
    #     id: id
    #   journalEntry.fetch()
    #   journalEntry

    # newJournalEntry: ->
    #   new Entities.JournalEntry

  App.reqres.setHandler "journal:entities", (mentee) ->
    API.getJournalEntries mentee

  # App.reqres.setHandler "journal:entity", (id) ->
  #   API.getJournalEntry id

  # App.reqres.setHandler "new:journal:entity", ->
  #   API.newJournalEntry()