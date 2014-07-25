@MM.module "UsersApp.Login", (Login, App, Backbone, Marionette, $, _) ->

  class Login.View extends App.Views.ItemView
    template: 'users/login/login'
    
    events:
      'submit form': 'login'

    initialize: ->
      @model = new App.Entities.UserSession()

    render: ->
      super
      rivets.bind(@$el, {userSession: @model})
      return @

    login: (e) ->
      e.preventDefault()

      @$el.find('#login-form button').button('loading');

      @model.login().always =>
        @$el.find('#login-form button').button('reset');
