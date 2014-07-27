@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  Model = App.Models.Supers.Model
  Collection = App.Collections.Supers.Collection
  User = App.Entities.User

  class Entities.UserSessionCollection extends Entities.Collection

  class Entities.UserSession extends Entities.Model
    urlRoot: Collection.serverUrl('users/session.json')
    paramRoot: 'user'

    defaults:
      "email": ""
      "password": ""

    login: ->
      deferred = @save()

      deferred.then(
        # success
        (user) => 
          
          # TODO: Possibly move this to external handler
          App.currentUser = new User(user)
          App.currentSession = @
          App.vent.trigger("authentication:logged_in", App.currentUser)
        # error
        (xhr) ->
          App.vent.trigger("authentication:logged_in_failed", xhr)
      )

      return deferred

    logout: ->
      deferred = @destroy()

      deferred.then ->
        App.currentSession = null
        App.currentUser = null
        App.vent.trigger "authentication:logged_out"

      return deferred

    toJSON: ->
      data = {}
      data[@paramRoot] = super
      return data

    methodUrl:
      'delete': Collection.serverUrl('users/session.json')

    sync: (method, model, options) ->
      if (model.methodUrl && model.methodUrl[method.toLowerCase()])
        options = options || {}
        options.url = model.methodUrl[method.toLowerCase()]
      Backbone.sync(method, model, options)
    