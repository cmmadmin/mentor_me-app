MM.module "ServicesApp", (Services, App, Backbone, Marionette, $, _) ->

  class Services.Session extends App.Controllers.Application
    Store = App.Utilities.LocalStorage
    initialize: ->
      @_initEvents()
      @loadSession()

    loadSession: ->
      @token = Store.getItem('auth_token')
      if @token
        App.currentSession = new App.Entities.UserSession(auth_token: @token)
        @bootstrap()
      else
        # Throw a false session:loaded event to indicate that we checked for session and there wasn't one
        App.vent.trigger('session:loaded', false)
        # App.goRoot()

    destroySession: ->
      @clearBootstrap()
      @token = App.currentUser = App.currentSession = null
      Store.removeItem('auth_token')

    bootstrap: ->
      sync = $.ajax(
        url: App.Config.ApplicationConfig.SERVER_URL + 'users/data'
      )
      sync.then(
        # Boostrap loaded successfully
        (data) =>
          App.currentUser = new App.Entities.User(data.current_user)
          App.Models.Mentee._all = new App.Collections.Mentees(data.mentees)
          App.Models.Edition._all = new App.Collections.Editions(data.editions)
          App.Entities.DevelopCategory._all = new App.Entities.DevelopCategoriesCollection(data.develop_categories)
          App.Entities.DevelopCurriculum._all = new App.Entities.DevelopCurriculumsCollection(data.develop_curriculums)

          # If bootstrap succeeded, then session is valid
          # Record auth_token and bootstrapped state
          Store.setItem('auth_token', @token)
          App.currentSession.set('boostrapped', true)
          # Throw a true session:loaded to indicate we found and loaded a user
          App.vent.trigger('session:loaded', true)
      )

    clearBootstrap: ->
      if App.currentSession and App.currentSession.get('bootstrapped')
        _.each App.Entities, (entity) ->
          entity._all = null if entity._all?
        _.each App.Models, (model) ->
          model._all = null if model._all?
        App.currentSession.set "boostrapped", false

    _initEvents: ->
      @listenTo App.vent, "session:notauthenticated authentication:logged_out", =>
        @destroySession()
      @listenTo App.vent, "authentication:logged_in", (session) =>
        App.currentSession = session
        @token = session.get('auth_token')
        @bootstrap()


