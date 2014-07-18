@MM.module "DevelopApp", (DevelopApp, App, Backbone, Marionette, $, _) ->

  class DevelopApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:id/develop": "show"

  API =
    show: ->
      # App.vent.trigger "nav:choose", "Admin"
      new DevelopApp.Show.Controller

  App.addInitializer ->
    new DevelopApp.Router
      controller: API
