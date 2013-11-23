MM = require('MentorMe')
IntroView = require('views/snapshot/IntroView')
SelfAssessView = require('views/snapshot/SelfAssessView')
SurveyView = require('views/survey/SurveyView')
PreInteractiveQuizView = require('views/snapshot/PreInteractiveQuizView')
InteractiveQuizView = require('views/snapshot/InteractiveQuizView')
PostInteractiveQuizView = require('views/snapshot/PostInteractiveQuizView')
ActiveSnapshotView = require('views/snapshot/ActiveSnapshotView')
ToolLayout = require('views/ToolLayout')
SnapshotFsm = require('models/state_machines/SnapshotFsm')
SnapshotViewFsm = require('models/state_machines/SnapshotViewFsm')
Controller = require('./supers/Controller')

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
  

  showUntapped: ->
    view = new IntroView(model: @model)
    @listenTo view, "snapshot:intro:start:clicked", ->
      @workflow.handle('start')

    @layout.mainRegion.show(view)

  showActiveSelfassess: ->
    view = new SurveyView
      survey: @model.edition().snapshotSelfAssessmentSurvey()
      grouped: true
      title: "Assess"
      icon: "camera-retro"
      showLastSlide: !@isActive()
      showCompleteBtn: !@isActive()
    @listenTo view, 'complete', @completeSurvey
    @listenTo view, 'savenclose', @saveAndCloseSurvey

    @layout.mainRegion.show(view)

  showActivePreInteractivequiz: ->
    view = new PreInteractiveQuizView(model: @model)
    @listenTo view, "snapshot:preinteractive:start:clicked", ->
      @workflow.handle('advance')
    @layout.mainRegion.show view

  showActiveInteractivequiz: ->
    view = new SurveyView
      survey: @model.edition().snapshotInteractiveSurvey()
      title: "Explore"
      icon: "camera-retro"
      showCompleteBtn: !@isActive()
    @listenTo view, 'complete', @completeSurvey
    @listenTo view, 'savenclose', @saveAndCloseSurvey
    @layout.mainRegion.show(view)

  showActivePostInteractivequiz: ->
    view = new PostInteractiveQuizView(model: @model)
    @listenTo view, "snapshot:postinteractive:confirm:clicked", ->
      @workflow.handle('advance')
    @layout.mainRegion.show view

  showActiveObserve: ->
    view = new SurveyView
      survey: @model.edition().snapshotObservationsSurvey()
      title: "Observe"
      icon: "camera-retro"
      showCompleteBtn: !@isActive()
    @listenTo view, 'savenclose', @saveAndCloseSurvey
    @layout.mainRegion.show(view)

  showActive: ->
    view = new ActiveSnapshotView(model: @model)
    @listenTo view, 'snapshot:selfassess:clicked', ->
      @showActiveSelfassess()
    @listenTo view, 'snapshot:explore:clicked', ->
      @showActiveInteractivequiz()
    @listenTo view, 'snapshot:observe:clicked', ->
      @showActiveObserve()
    @layout.mainRegion.show view

  showComplete: ->
    @showActive()


  saveAndCloseSurvey: =>
    profile = MM.request "get:current:profile"
    profile.save()
    if(@state.state == 'active' || @state.state == 'complete')
      @showActive()
    else
      Backbone.history.navigate('mentees/' + @model.get('mentee_id'), trigger: true)
    

  completeSurvey: =>
    profile = MM.request "get:current:profile"
    @workflow.handle('advance')
    profile.save()


  getLayoutView: ->
    new ToolLayout()

  buildWorkflow: ->
    profile = MM.request "get:current:profile"
    @workflow = new SnapshotViewFsm()
    @listenTo @workflow, 'transition', (transition) =>
      @['show' + $.camelCase('pre-' + transition.toState.split(':').join('-')).substr(3)]()
   
    # @listenTo @state, 'transition', (transition) => @workflow.transition transition
  
  startWorkflow: (state) ->
    @workflow.transition state

  isActive: ->
    @workflow.state == "active"

  onClose: ->
    delete @workflow
    delete @layout
    delete @state
