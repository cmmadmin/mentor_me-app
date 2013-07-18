MM = require('MentorMe')
Model = require('./supers/Model')
Collection = require('collections/supers/Collection')
User = require('./User')

module.exports = class UserSession extends Model
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
        MM.currentUser = new User(user)
        MM.vent.trigger("authentication:logged_in", MM.currentUser)
      # error
      (xhr) ->
        MM.vent.trigger("authentication:logged_in_failed", xhr)
    )

    return deferred

  toJSON: ->
    data = {}
    data[@paramRoot] = super
    return data