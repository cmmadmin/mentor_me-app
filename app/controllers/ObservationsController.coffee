MM = require('MentorMe')
SurveyView = require('views/survey/SurveyView')
ToolLayout = require('views/ToolLayout')
Controller = require('./supers/Controller')

module.exports = class ObservationsController extends Controller

  initialize: (options) ->
    console.log 'ObservationsController:Controller:initialize'
    @region = options.region
    @model = options.model

    #@state = MM.request "get:profile:state", "interview"

    @layout = @getLayoutView()
    @show @layout
    @showActiveObserve()

    console.log 'end ObservationsController:Controller:initialize'

  getLayoutView: ->
    new ToolLayout()

  showActiveObserve: ->
    view = new SurveyView
      survey: @model.edition().snapshotObservationsSurvey()
      title: "Long Term Observations"
      icon: "camera-retro"
      showCompleteBtn: false
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