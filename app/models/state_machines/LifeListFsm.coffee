@MM.module "Models.StateMachines", (StateMachines, App, Backbone, Marionette, $, _) ->

  StateMachines.LifeListFsm = StateMachines.ToolFsm.extend
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