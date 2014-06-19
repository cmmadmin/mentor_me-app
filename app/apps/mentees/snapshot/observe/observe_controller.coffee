@MM.module "MenteesApp.Observe", (Observe, App, Backbone, Marionette, $, _) ->

  class Observe.Controller extends App.Controllers.SnapshotController

    showActive: ->
      view = new App.Views.SurveyView
        survey: @model.edition().snapshotObservationsSurvey()
        title: "Long Term Observations"
        icon: "camera-retro"
        showCompleteBtn: false
      @listenTo view, 'savenclose', @saveAndCloseSurvey
      @layout.mainRegion.show(view)

