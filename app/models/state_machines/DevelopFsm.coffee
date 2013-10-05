ToolFsm = require('./ToolFsm')

module.exports = DevelopFsm = ToolFsm.extend

  
  # eventListeners:
  #   onTransition: (trans) ->
  #     @profile.set('develop_state', trans.toState)
  #     
  updateProgress: ->
    @progressCache = @profile.developProgress()
    # @validateState()
    @progressCache

  states:
    complete:
      _onEnter: ->
        @profile.state.lifelist.handle('enable') if @profile.state.lifelist