SnapshotController = require('controllers/SnapshotController')
SurveyView = require('views/survey/SurveyView')

module.exports = class SelfAssessController extends SnapshotController

  showActive: ->
    console.log 'SelfAssessController:showActiveSelfassess'
    view = new SurveyView
      survey: @model.edition().snapshotSelfAssessmentSurvey()
      grouped: true
      title: "Self Assessment"
      icon: "camera-retro"
      showLastSlide: false
      showCompleteBtn: false
    @listenTo view, 'complete', @completeSurvey
    @listenTo view, 'savenclose', @saveAndCloseSurvey

    @layout.mainRegion.show(view)
