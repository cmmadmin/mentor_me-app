@MM.module "UsersApp.Login", (Login, App, Backbone, Marionette, $, _) ->

  class Login.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
          type: 'Info'
          promptId: 'login'
      ]

    initialize: ->
      @layout = @getLayoutView()

      @show @layout

    getLayoutView: ->
      new Login.Layout