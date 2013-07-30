ToolFsm = require('./ToolFsm')

module.exports = DevelopFsm = ToolFsm.extend

  empty: ""
  # eventListeners:
  #   onTransition: (trans) ->
  #     @profile.set('develop_state', trans.toState)