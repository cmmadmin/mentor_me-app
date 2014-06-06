@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  SnapshotController = Controllers.SnapshotController
  SurveyView = App.Views.Survey.SurveyView

  class Controllers.SelfAssessController extends SnapshotController

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
