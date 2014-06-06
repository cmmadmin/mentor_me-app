# Base Fsm for all tools (Snapshot, Develop, Life List)
# 
@MM.module "Models.StateMachines", (StateMachines, App, Backbone, Marionette, $, _) ->

  StateMachines.ToolFsm = machina.Fsm.extend
    initialize: ->

    # Returns a cached progress percentage
    progress: ->
      @progressCache or @updateProgress()

    ## This method should be overriden by sub fsms
    updateProgress: ->
      console.error "Must be overriden in sub fsm" # We should never get here
      @progressCache = Math.floor(Math.random() * 101)

    validateState: ->
      @updateProgress()
      if @progress() == 100
        @transition 'complete'
      

    # Used by buttons to get basic states (without in between states, snapshot in particular)
    getFacadeFsm: ->

    close: ->

    initialState: 'disabled'
    states: 
      disabled:
        enable: ->
          @transition 'untapped'
      untapped:
        start: ->
          @transition 'active'
        complete: ->
          @transition 'complete'
      active:
        complete: ->
          @transition 'complete'
      complete: {}