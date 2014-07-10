@MM.module "PromptApp", (PromptApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    show: (id) ->
      new PromptApp.Show.Controller
        region: App.promptRegion
        id: id

  App.commands.setHandler "show:prompt", (id) ->
    API.show id