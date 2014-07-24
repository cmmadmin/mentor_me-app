@MM.module "HomeApp", (HomeApp, App, Backbone, Marionette, $, _) ->

  class HomeApp.Router extends Marionette.AppRouter
    appRoutes:
      "" : "show"

  API = 
    show: ->
      new HomeApp.Show.Controller

  App.vent.on "home:clicked user:notauthenticated authentication:logged_out", ->
    App.navigate ""
    API.show()

  App.addInitializer ->
    new HomeApp.Router
      controller: API