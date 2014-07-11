MM.module "PromptApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application
    initialize: (options) ->
      { promptId } = options 
      prompt = App.Config.Prompts[promptId]

      throw Error("Invalid promptId") unless prompt
      promptModel = new App.Entities.Prompt(prompt)

      @layout = @getPromptView promptModel

      @show @layout

    getPromptView: (promptModel) ->
      new Show.Prompt
        model: promptModel