@MM.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      "login" : "login"
      "user/new" : "_new"

  API =
    login: ->
      new UsersApp.Login.Controller

    _new: ->
      new UsersApp.EditNew.Controller

  App.vent.on "user:login:clicked", ->
    App.navigate "login"
    API.login

  App.vent.on "user:new:clicked", ->
    App.navigate "user/new"
    API._new
    
  App.addInitializer ->
    new UsersApp.Router
      controller: API
