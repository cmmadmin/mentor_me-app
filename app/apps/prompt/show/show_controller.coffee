MM.module "PromptApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application
    initialize: (options) ->
      { page_id } = options 
      prompt = App.Config.Prompts["contact_home"]

      if prompt
        promptModel = new App.Entities.Prompt(prompt)

      @layout = @getPromptView promptModel

      @show @layout

    getPromptView: (promptModel) ->
      new Show.Prompt
        model: promptModel