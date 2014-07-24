@MM.module "HomeApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: 'home/show/show'

    triggers:
      "click #register-button" : "register:button:clicked"
      "click #login-button" : "login:button:clicked"