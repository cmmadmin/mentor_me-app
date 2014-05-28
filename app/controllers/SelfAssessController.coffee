MM = require('MentorMe')
SurveyView = require('views/survey/SurveyView')
ToolLayout = require('views/ToolLayout')
Controller = require('./supers/Controller')

module.exports = class SelfAssessController extends Controller

  initialize: (options) ->
    console.log 'SelfAssessController:Controller:initialize'
    @region = options.region
    @model = options.model

    #@state = MM.request "get:profile:state", "selfassess"

    @layout = @getLayoutView()
    @show @layout
    @showActiveSelfassess()

    console.log 'end SelfAssessController:Controller:initialize'

  getLayoutView: ->
    new ToolLayout()

  showActiveSelfassess: ->
    console.log 'SelfAssessController:showActiveSelfassess'
    view = new SurveyView
      survey: @model.edition().snapshotSelfAssessmentSurvey()
      grouped: true
      title: "Assess"
      icon: "camera-retro"
      showLastSlide: false
      showCompleteBtn: false
    @listenTo view, 'complete', @completeSurvey
    @listenTo view, 'savenclose', @saveAndCloseSurvey

    @layout.mainRegion.show(view)

  saveAndCloseSurvey: =>
    profile = MM.request "get:current:profile"
    profile.save()
    #if(@state.state == 'active' || @state.state == 'complete')
    #  @showActive()
    #else
    Backbone.history.navigate('mentees/' + @model.get('mentee_id'), trigger: true)

  completeSurvey: =>
    profile = MM.request "get:current:profile"
    #@workflow.handle('advance')
    profile.save()