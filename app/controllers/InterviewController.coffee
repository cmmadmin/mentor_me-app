MM = require('MentorMe')
SurveyView = require('views/survey/SurveyView')
ToolLayout = require('views/ToolLayout')
Controller = require('./supers/Controller')

module.exports = class InterviewController extends Controller

  initialize: (options) ->
    console.log 'InterviewController:Controller:initialize'
    @region = options.region
    @model = options.model

    #@state = MM.request "get:profile:state", "interview"

    @layout = @getLayoutView()
    @show @layout
    @showActiveInteractivequiz()

    console.log 'end InterviewController:Controller:initialize'

  getLayoutView: ->
    new ToolLayout()

  showActiveInteractivequiz: ->
    console.log 'InterviewController:showActiveInteractivequiz'
    view = new SurveyView
      survey: @model.edition().snapshotInteractiveSurvey()
      title: "Interview"
      icon: "camera-retro"
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