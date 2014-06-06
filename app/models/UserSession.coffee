@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection
  User = Models.User

  class Models.UserSession extends Model
    urlRoot: Collection.serverUrl('users/sign_in.json')
    paramRoot: 'user'

    defaults:
      "email": ""
      "password": ""

    login: ->
      deferred = @save()

      deferred.then(
        # success
        (user) -> 
          
          # TODO: Possibly move this to external handler
          App.currentUser = new User(user)
          App.vent.trigger("authentication:logged_in", App.currentUser)
        # error
        (xhr) ->
          App.vent.trigger("authentication:logged_in_failed", xhr)
      )

      return deferred

    toJSON: ->
      data = {}
      data[@paramRoot] = super
      return data