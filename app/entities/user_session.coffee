@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  Model = App.Models.Supers.Model
  Collection = App.Collections.Supers.Collection
  User = App.Entities.User

  class Entities.UserSessionCollection extends Entities.Collection

  class Entities.UserSession extends Entities.Model
    urlRoot: Collection.serverUrl('users/session.json')
    paramRoot: 'user'

    login: ->

      deferred = @save()

      deferred.then(
        # success
        (user) => 
          App.vent.trigger("authentication:logged_in", @)
        # error
        (xhr) ->
          App.vent.trigger("authentication:logged_in_failed", xhr)
      )
      deferred.always =>
        @unset 'password'

      return deferred

    logout: ->
      deferred = @destroy()

      deferred.then ->
        App.vent.trigger "authentication:logged_out"

      return deferred

    isNew: ->
      !@get('auth_token')?

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
      super
    