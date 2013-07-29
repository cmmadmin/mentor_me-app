ToolFsm = require('./ToolFsm')

module.exports = SnapshotFsm = ToolFsm.extend

  updateProgress: ->
    # @progressCache = @profile.snapshotProgress()
    @progressCache = Math.floor(Math.random() * 101)

  initialState: 'untapped'
  states:
    untapped:
      start: =>
        @transition 'active:selfassess'
    'active:selfassess':
      advance: =>
        @transition 'active:pre:interactivequiz'
    'active:pre:interactivequiz':
      advance: =>
        @transition 'active:interactivequiz'
    'active:interactivequiz':
      advance: =>
        @transition 'active'
