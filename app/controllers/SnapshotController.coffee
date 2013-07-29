MM = require('MentorMe')
IntroView = require('views/snapshot/IntroView')
SelfAssessView = require('views/snapshot/SelfAssessView')
SurveyView = require('views/survey/SurveyView')
InteractiveQuizView = require('views/snapshot/InteractiveQuizView')
ToolLayout = require('views/ToolLayout')
SnapshotFsm = require('models/state_machines/SnapshotFsm')
Controller = require('./supers/Controller')

class SnapshotViewFsm

module.exports = class SnapshotController extends Controller

  initialize: (options) ->
    console.log 'SnapshotModule:Controller:initialize'
    @region = options.region
    @model = options.model

    @state = MM.request "get:profile:state", "snapshot"

    @layout = @getLayoutView()

    @buildWorkflow()
    @listenTo @layout, "show", =>
      @startWorkflow(@state.state)

    @show @layout


  startInteractiveQuiz: ->
    view = new InteractiveQuizView(@model)
    @region.show(view)

  showUntapped: ->
    view = new IntroView(model: @model)
    @listenTo view, "snapshot:intro:start:clicked", ->
      @workflow.handle('start')

    @region.show(view)

  showActiveSelfassess: ->
    view = new SurveyView(survey: @model.edition().snapshotSelfAssessmentSurvey(), grouped: true);
    @region.show(view)

  getLayoutView: ->
    new ToolLayout()

  buildWorkflow: ->
    @workflow = new SnapshotViewFsm()
    @listenTo @workflow, 'transition', (transition) =>
      @['show' + $.camelCase('pre-' + transition.toState.replace(':','-')).substr(3)]();
   
    @listenTo @state, 'transition', (transition) => @workflow.transition transition
  
  startWorkflow: (state) ->
    @workflow.transition state

SnapshotViewFsm = SnapshotFsm.extend
  initialState: 'uninitialized'
  states:
    uninitialized: {}
    'untapped':
      start: ->
        @transition 'active:selfassess'
        MM.vent.trigger('current:snapshot:handle', 'start')
    'active:selfassess':
      advance: -> 
        @transition 'active:post:selfassess'
        MM.vent.trigger('current:snapshot:handle', 'advance')
    'active:post:selfassess':
      confirm: -> @transition 'active:pre:interactivequiz'
    'active:interactivequiz':
      advance: -> 
        @transition 'active:post:interactivequiz'
        MM.vent.trigger('current:snapshot:handle', 'advance')
