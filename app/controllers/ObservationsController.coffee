@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  SnapshotController = App.Controllers.SnapshotController
  SurveyView = App.Views.Survey.SurveyView

  class Controllers.ObservationsController extends SnapshotController

    showActive: ->
      view = new SurveyView
        survey: @model.edition().snapshotObservationsSurvey()
        title: "Long Term Observations"
        icon: "camera-retro"
        showCompleteBtn: false
      @listenTo view, 'savenclose', @saveAndCloseSurvey
      @layout.mainRegion.show(view)

