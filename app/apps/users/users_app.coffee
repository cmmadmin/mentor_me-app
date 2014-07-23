@MM.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      "login" : "login"

  API =
    login: ->
      new UsersApp.Login.Controller

  App.vent.on "user:login:clicked", ->
    App.navigate "login"
    API.login
    
  App.addInitializer ->
    new UsersApp.Router
      controller: API
