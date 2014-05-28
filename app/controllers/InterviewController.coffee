SnapshotController = require('controllers/SnapshotController')
SurveyView = require('views/survey/SurveyView')

module.exports = class InterviewController extends SnapshotController

  showActive: ->
    console.log 'InterviewController:showActiveInteractivequiz'
    view = new SurveyView
      survey: @model.edition().snapshotInteractiveSurvey()
      title: "Interview"
      icon: "camera-retro"
      showCompleteBtn: false
    @listenTo view, 'complete', @completeSurvey
    @listenTo view, 'savenclose', @saveAndCloseSurvey
    @layout.mainRegion.show(view)

  showActivePreInteractivequiz: ->
    view = new PreInteractiveQuizView(model: @model)
    @listenTo view, "snapshot:preinteractive:start:clicked", ->
      @workflow.handle('advance')
    @layout.mainRegion.show view

  showActivePostInteractivequiz: ->
    view = new PostInteractiveQuizView(model: @model)
    @listenTo view, "snapshot:postinteractive:confirm:clicked", ->
      @workflow.handle('advance')
    @layout.mainRegion.show view
