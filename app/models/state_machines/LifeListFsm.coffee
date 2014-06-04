@MM.module "Models.StateMachines", (StateMachines, App, Backbone, Marionette, $, _) ->

  StateMachines.LifeListFsm = Models.ToolFsm.extend
    # eventListeners:
    #   onTransition: (trans) ->
    #     @profile.set('lifelist_state', trans.toState)
    #     
    validateState: ->
      # do nothing
    states:
      untapped:
        start: ->
          # do nothing