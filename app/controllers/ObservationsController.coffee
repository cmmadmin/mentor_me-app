@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  SnapshotController = App.Controllers.SnapshotController

  class Controllers.ObservationsController extends SnapshotController

    showActive: ->
      view = new App.Views.SurveyView
        survey: @model.edition().snapshotObservationsSurvey()
        title: "Long Term Observations"
        icon: "camera-retro"
        showCompleteBtn: false
      @listenTo view, 'savenclose', @saveAndCloseSurvey
      @layout.mainRegion.show(view)

