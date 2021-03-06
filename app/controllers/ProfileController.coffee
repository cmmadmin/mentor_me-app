# This is more of a "module" than a controller, but we'll use this for now.
@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  class Controllers.ProfileController extends Marionette.Controller

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
      @listenTo @profile.state.snapshot, 'transition', (trans) =>
        @profile.set('snapshot_state', trans.toState)

    initHandlers: ->
      MM.reqres.setHandler 'get:current:profile', =>
        return @profile

      MM.reqres.setHandler 'get:profile:state', (tool) =>
        return @profile.state[tool]


    removeHandlers: ->
      _.each ['get:current:profile', 'get:profile:state'], (handler) ->
        MM.reqres.removeHandler handler

