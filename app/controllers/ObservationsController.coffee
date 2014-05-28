SnapshotController = require('controllers/SnapshotController')
SurveyView = require('views/survey/SurveyView')

module.exports = class ObservationsController extends SnapshotController

  showActive: ->
    view = new SurveyView
      survey: @model.edition().snapshotObservationsSurvey()
      title: "Long Term Observations"
      icon: "camera-retro"
      showCompleteBtn: false
    @listenTo view, 'savenclose', @saveAndCloseSurvey
    @layout.mainRegion.show(view)

