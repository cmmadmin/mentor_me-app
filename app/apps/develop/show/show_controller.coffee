@MM.module "DevelopApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'develop'
      ]
    initialize: (options) ->
      { id } = options
      @layout = @getLayoutView()

      @model = App.request "mentee:entity", id 
      @categories = App.request "develop_category:entities"

      @listenTo @layout, "show", =>
        @lifeListRegion()
        @suggestedStepsRegion()
        @planRegion()

      @show @layout

    getLayoutView: ->
      new Show.Layout

    lifeListRegion: ->
      new App.DevelopApp.LifeList.Controller
        region: @layout.lifeListRegion
        categories: @categories

    suggestedStepsRegion: ->
      new App.DevelopApp.SuggestedSteps.Controller
        region: @layout.stepsRegion
        categories: @categories

    planRegion: ->
      new App.DevelopApp.Plan.Controller
        region: @layout.planRegion