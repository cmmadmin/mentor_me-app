MM = require('MentorMe')
SnapshotFsm = require('./SnapshotFsm')

module.exports = SnapshotViewFsm = SnapshotFsm.extend
  initialState: 'uninitialized'
  states:
    uninitialized: {}
    'untapped':
      start: ->
        @transition 'active:selfassess'
        MM.vent.trigger('current:snapshot:handle', 'start')
    'active:selfassess':
      advance: -> 
        @transition 'active:pre:interactivequiz'
        MM.vent.trigger('current:snapshot:handle', 'advance')
    'active:pre:interactivequiz':
      advance: ->
        @transition 'active:interactivequiz'
        MM.vent.trigger('current:snapshot:handle', 'advance')
    'active:interactivequiz':
      advance: -> 
        @transition 'active:post:interactivequiz'
        MM.vent.trigger('current:snapshot:handle', 'advance')