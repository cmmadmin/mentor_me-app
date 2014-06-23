@MM.module "MenteesApp.Observe", (Observe, App, Backbone, Marionette, $, _) ->

  class Observe.Controller extends App.Controllers.SnapshotController

    showActive: ->
      view = new App.Views.SurveyView
        survey: @model.edition().snapshotObservationsSurvey()
        title: "Observe"
        showCompleteBtn: false
      @listenTo view, 'savenclose', @saveAndCloseSurvey
      @layout.mainRegion.show(view)

      scrollComp = App.request "ion:scroll:component", view
      @show scrollComp, region: @region

