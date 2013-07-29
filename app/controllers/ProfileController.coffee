# This is more of a "module" than a controller, but we'll use this for now.
MM = require('MentorMe')
module.exports = class ProfileController extends Marionette.Controller

  initialize: (opts) ->
    @setProfile opts.profile
    @initHandlers();

  onClose: ->
    @removeHandlers();
    @profile.cleanup() if @profile?

  setProfile: (profile) ->
    if (profile != @profile)
      @profile.cleanup() if @profile?
      @profile = profile
      MM.vent.trigger('current:profile:changed', @profile)
      @prepProfile();

  prepProfile: ->
    # Cache any progress, etc.
    @profile.initStateMachines()

  initHandlers: ->
    MM.reqres.addHandler 'get:current:profile', =>
      return @profile

    MM.reqres.addHandler 'get:profile:state', (tool) =>
      return @profile.state[tool]


  removeHandlers: ->
    _.each ['get:current:profile', 'get:profile:state'], (handler) ->
      MM.reqres.removeHandler handler

