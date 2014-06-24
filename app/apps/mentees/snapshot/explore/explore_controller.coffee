@MM.module "MenteesApp.Explore", (Explore, App, Backbone, Marionette, $, _) ->

  class Explore.Controller extends App.Controllers.SnapshotController

    showActive: ->
      console.log 'InterviewController:showActiveInteractivequiz'
      view = new App.Views.SurveyView
        survey: @model.edition().snapshotInteractiveSurvey()
        title: "Explore"
        showCompleteBtn: false
      @listenTo view, 'complete', @completeSurvey
      @listenTo view, 'savenclose', @saveAndCloseSurvey

      @layout.mainRegion.show(view)
      #scrollComp = App.request "ion:scroll:component", view
      #@show scrollComp, region: @region

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
