@MM.module "Models.StateMachines", (StateMachines, App, Backbone, Marionette, $, _) ->

  StateMachines.SnapshotViewFsm = Models.SnapshotFsm.extend
    initialState: 'uninitialized'
    states:
      uninitialized: {}
      'untapped':
        start: ->
          @transition 'active:selfassess'
          App.vent.trigger('current:snapshot:handle', 'start')
      'active:selfassess':
        advance: -> 
          @transition 'active:pre:interactivequiz'
          App.vent.trigger('current:snapshot:handle', 'advance')
      'active:pre:interactivequiz':
        advance: ->
          @transition 'active:interactivequiz'
          App.vent.trigger('current:snapshot:handle', 'advance')
      'active:interactivequiz':
        advance: -> 
          @transition 'active:post:interactivequiz'
          App.vent.trigger('current:snapshot:handle', 'advance')