ToolFsm = require('./ToolFsm')

module.exports = LifeListFsm = ToolFsm.extend
  # eventListeners:
  #   onTransition: (trans) ->
  #     @profile.set('lifelist_state', trans.toState)
  states:
    untapped:
      start: ->
        # do nothing