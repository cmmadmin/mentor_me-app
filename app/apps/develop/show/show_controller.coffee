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
      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @lifeListRegion()

      @show @layout

    getLayoutView: ->
      new Show.Layout

    lifeListRegion: ->
      new App.DevelopApp.LifeList.Controller
        region: @layout.lifeListRegion
