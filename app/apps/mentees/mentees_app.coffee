@MM.module "MenteesApp", (MenteesApp, App, Backbone, Marionette, $, _) ->

  class MenteesApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:id"  : "show"
      "mentees" : "list"
      "mentees/new" : "_new"
      "mentees/:id/edit" : "edit"

  API =
    list: ->
      new MenteesApp.List.Controller

    show: (id, member) ->
      new MenteesApp.Show.Controller
        id: id
        crew: member

    _new: (mentees) ->
      new MenteesApp.EditNew.Controller
        mentees: mentees

    edit: (id, mentee) ->
      new MenteesApp.EditNew.Controller
        id: id
        mentee: mentee

  # App.vent.on "mentee:clicked mentee:created", (mentee) ->
  #   App.navigate Routes.edit_mentee_path(mentee.id)
  #   API.edit mentee.id, mentee

  App.vent.on "new:mentee:clicked", (mentees) ->
    App.navigate "mentees/new"
    API._new mentees

  App.vent.on "edit:mentee:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/edit"
    API.edit mentee.id, mentee

  App.addInitializer ->
    new MenteesApp.Router
      controller: API