@MM.module "MenteesApp.Assess", (Assess, App, Backbone, Marionette, $, _) ->

  class Assess.Controller extends App.Controllers.SnapshotController

    showActive: ->
      console.log 'SelfAssessController:showActiveSelfassess'
      view = new App.Views.SurveyView
        survey: @model.edition().snapshotSelfAssessmentSurvey()
        grouped: true
        title: "Assess"
        showLastSlide: false
        showCompleteBtn: false
      @listenTo view, 'complete', @completeSurvey
      @listenTo view, 'savenclose', @saveAndCloseSurvey

      @layout.mainRegion.show(view)
#      scrollComp = App.request "ion:scroll:component", view
#      @show scrollComp, region: @region
