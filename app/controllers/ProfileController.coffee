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
    @listenTo MM.vent, 'current:snapshot:handle', (e) =>
      @profile.state.snapshot.handle(e)
    @listenTo MM.vent, 'current:develop:handle', (e) =>
      @profile.state.develop.handle(e)
    @listenTo MM.vent, 'current:lifelist:handle', (e) =>
      @profile.state.lifelist.handle(e)
    @listenTo @profile.state.snapshot, 'transition', (trans) =>
      @profile.set('snapshot_state', trans.toState)
    @listenTo @profile.state.develop, 'transition', (trans) =>
      @profile.set('develop_state', trans.toState)
    @listenTo @profile.state.lifelist, 'transition', (trans) =>
      @profile.set('lifelist_state', trans.toState)

  initHandlers: ->
    MM.reqres.setHandler 'get:current:profile', =>
      return @profile

    MM.reqres.setHandler 'get:profile:state', (tool) =>
      return @profile.state[tool]


  removeHandlers: ->
    _.each ['get:current:profile', 'get:profile:state'], (handler) ->
      MM.reqres.removeHandler handler

