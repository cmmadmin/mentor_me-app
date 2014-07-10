MM.module "PromptApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application
    initialize: (options) ->
      @layout = @getPromptView()
      console.log text

      @show @layout

    getPromptView: ->
      new Show.Prompt