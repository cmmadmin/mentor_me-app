@MM.module "PromptApp", (PromptApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    show: (page_id) ->
      new PromptApp.Show.Controller
        region: App.promptRegion
        page_id: page_id

  App.commands.setHandler "show:prompt", (page_id) ->
    API.show page_id