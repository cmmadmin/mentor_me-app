ToolFsm = require('./ToolFsm')

module.exports = SnapshotFsm = ToolFsm.extend

  # eventListeners:
  #   onTransition: (trans) ->
  #     @profile.set('snapshot_state', trans.toState)
  #     

  updateProgress: ->
    # validate = @progressCache?
    @progressCache = @profile.snapshotProgress()
    # @validateState()
    @progressCache
    # @progressCache = Math.floor(Math.random() * 101)

  initialState: 'untapped'
  states:
    untapped:
      start: ->
        @transition 'active:selfassess'
    'active:selfassess':
      advance: ->
        @transition 'active:pre:interactivequiz'
    'active:pre:interactivequiz':
      advance: ->
        @transition 'active:interactivequiz'
    'active:interactivequiz':
      advance: ->
        @transition 'active'
    'active:post:interactivequiz':{}
    complete:
      _onEnter: ->
        @profile.state.develop.handle('enable') if @profile && @profile.state.develop


