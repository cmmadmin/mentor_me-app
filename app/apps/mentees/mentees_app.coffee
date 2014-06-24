@MM.module "MenteesApp", (MenteesApp, App, Backbone, Marionette, $, _) ->

  class MenteesApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:id"  : "show"
      "mentees" : "list"
      "mentees/new" : "_new"
      "mentees/:id/edit" : "edit"
      "mentees/:id/assess" : "assess"
      "mentees/:id/explore" : "explore"
      "mentees/:id/observe" : "observe"
      "mentees/:id/journal" : "journal"

  API =
    list: ->
      new MenteesApp.List.Controller

    show: (id) ->
      new MenteesApp.Show.Controller
        id: id

    _new: (mentees) ->
      new MenteesApp.EditNew.Controller
        mentees: mentees

    edit: (id, mentee) ->
      new MenteesApp.EditNew.Controller
        id: id
        mentee: mentee

    assess: (id) ->
      new MenteesApp.Assess.Controller
        id: id
        region: App.appLayout.mainRegion

    explore: (id) ->
      new MenteesApp.Explore.Controller
        id: id

    observe: (id) ->
      new MenteesApp.Observe.Controller
        id: id
        region: App.appLayout.mainRegion

    journal: (id) ->
      new MenteesApp.Journal.Controller
        id: id
        region: App.appLayout.mainRegion

  # App.vent.on "mentee:clicked mentee:created", (mentee) ->
  #   App.navigate Routes.edit_mentee_path(mentee.id)
  #   API.edit mentee.id, mentee

  App.vent.on "new:mentee:clicked", (mentees) ->
    App.navigate "mentees/new"
    API._new mentees

  App.vent.on "edit:mentee:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/edit"
    API.edit mentee.id, mentee

  App.vent.on "snapshot:assess:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/assess"
    API.assess mentee

  App.vent.on "snapshot:explore:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/explore"
    API.explore mentee

  App.vent.on "snapshot:observe:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/observe"
    API.observe mentee

  App.vent.on "journal:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/journal"
    API.journal mentee

  App.addInitializer ->
    new MenteesApp.Router
      controller: API
