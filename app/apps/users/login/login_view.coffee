@MM.module "UsersApp.Login", (Login, App, Backbone, Marionette, $, _) ->

  class Login.Layout extends App.Views.Layout
    template: 'users/login/login'
    