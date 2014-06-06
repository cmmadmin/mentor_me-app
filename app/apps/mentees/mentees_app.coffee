@MM.module "MenteesApp", (MenteesApp, App, Backbone, Marionette, $, _) ->

  class MenteesApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees" : "list"

  API =
    list: ->
      new MenteesApp.List.Controller

  # App.vent.on "mentee:clicked mentee:created", (mentee) ->
  #   App.navigate Routes.edit_mentee_path(mentee.id)
  #   API.edit mentee.id, mentee

  App.addInitializer ->
    new MenteesApp.Router
      controller: API