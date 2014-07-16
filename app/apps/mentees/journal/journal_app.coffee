@MM.module "JournalApp", (JournalApp, App, Backbone, Marionette, $, _) ->

  class JournalApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:id/journal" : "list"
      "mentees/:id/journal/new" : "_new"
      "mentees/:id/journal/edit" : "edit"

  API =
    list: (mentee) ->
      new JournalApp.List.Controller
        mentee: mentee

    _new: (journalEntries) ->
      new JournalApp.EditNew.Controller
        journalEntries: journalEntries

    edit: (journalEntry) ->
      new JournalApp.EditNew.Controller
        journalEntry: journalEntry

  App.vent.on "new:journalentry:clicked", (journalEntries) ->
    App.navigate "mentees/#{journalEntries.owner.id}/journal/new"
    API._new journalEntries

  App.vent.on "edit:journalentry:clicked", (journalEntry) ->
    App.navigate "mentees/#{journalEntry.owner.id}/journal/edit"
    API.edit journalEntry

  App.vent.on "journal:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/journal"
    API.list mentee

  App.addInitializer ->
    new JournalApp.Router
      controller: API