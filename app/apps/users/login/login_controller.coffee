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

      @listenTo App.vent, "session:notauthenticated", ->
        navigator.notification.alert 'Invalid email or password' if navigator.notification?

      @show @layout

    getLayoutView: ->
      new Login.View

  App.commands.setHandler "user:login", (user) ->
    userSession = new App.Entities.UserSession(
      email: user.get('email')
      password: user.get('password')
    )
    userSession.login()