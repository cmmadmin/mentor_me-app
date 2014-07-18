@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.JournalEntry extends Entities.Model
    urlRoot: ->
      Entities.Collection.serverUrl('journal_entries')

  class Entities.JournalEntryCollection extends Entities.Collection
    model: Entities.JournalEntry
    url: ->
      Entities.Collection.serverUrl('mentees') + '/' + @owner.id + '/journal_entries'

    initialize: ->
      super

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

    getJournalEntry: (mentee, id) ->
      journalEntries = API.getJournalEntries mentee
      journalEntries.getOrFetch(id)

    # newJournalEntry: ->
    #   new Entities.JournalEntry

  App.reqres.setHandler "journal:entities", (mentee) ->
    API.getJournalEntries mentee

  App.reqres.setHandler "journal:entity", (mentee, id) ->
    API.getJournalEntry mentee, id

  # App.reqres.setHandler "new:journal:entity", ->
  #   API.newJournalEntry()