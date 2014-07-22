@MM.module "JournalApp", (JournalApp, App, Backbone, Marionette, $, _) ->

  class JournalApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:mentee_id/journal" : "list"
      "mentees/:mentee_id/journal/new" : "_new"
      "mentees/:mentee_id/journal/:id" : "edit"

  API =
    list: (mentee) ->
      new JournalApp.List.Controller
        mentee: mentee

    _new: (journalEntries) ->
      new JournalApp.EditNew.Controller
        journalEntries: journalEntries

    edit: (mentee_id, id) ->
      new JournalApp.EditNew.Controller
        id: id

  App.vent.on "new:journalentry:clicked", (journalEntries) ->
    App.navigate "mentees/#{journalEntries.owner.id}/journal/new"
    API._new journalEntries

  App.vent.on "journal:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/journal"
    API.list mentee

  App.addInitializer ->
    new JournalApp.Router
      controller: API