@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->
  UserSession = App.Models.UserSession

  class Views.LoginView extends Marionette.ItemView
    template: 'templates/Login'

    events:
      'submit form': 'login'

    initialize: ->
      @model = new UserSession()

    render: ->
      super
      rivets.bind(@$el, {userSession: @model})
      return @

    login: (e) ->
      # Prevent form submission
      e.preventDefault()

      @$el.find('#login-form button.btn-primary').button('loading');

      @model.login().always =>
        @$el.find('#login-form button.btn-primary').button('reset');