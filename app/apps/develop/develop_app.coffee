@MM.module "DevelopApp", (DevelopApp, App, Backbone, Marionette, $, _) ->

  class DevelopApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:id/develop": "show"

  API =
    show: (id) ->
      # App.vent.trigger "nav:choose", "Admin"
      new DevelopApp.Show.Controller
        id: id

  App.addInitializer ->
    new DevelopApp.Router
      controller: API

  App.vent.on "develop:clicked", (mentee) ->
    App.navigate "mentees/#{mentee.id}/develop"
    API.show mentee.id
