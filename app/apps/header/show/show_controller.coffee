@MM.module "HeaderApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      { navItem } = options
      @layout = @getHeaderView()

      @listenTo @layout, "show", =>
        @leftButtonsRegion navItem.get('leftButtons')
        @rightButtonsRegion navItem.get('rightButtons')

      @show @layout

    leftButtonsRegion: (buttons) ->
      buttonsView = @getNavButtonsView(buttons)
      @show buttonsView, region: @layout.leftButtonsRegion

    rightButtonsRegion: (buttons) ->
      buttonsView = @getNavButtonsView(buttons)
      @show buttonsView, region: @layout.rightButtonsRegion

    getHeaderView: ->
      new Show.Header

    getNavButtonsView: (buttons) ->
      new Show.NavButtons
        collection: buttons