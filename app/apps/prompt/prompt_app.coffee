@MM.module "PromptApp", (PromptApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    show: (promptId) ->
      new PromptApp.Show.Controller
        region: App.promptRegion
        promptId: promptId

  App.commands.setHandler "show:prompt", (promptId) ->
    if promptId?
      API.show promptId

  App.vent.on "prompt:hidden", (view) ->
  	view.remove()
  	view.unbind()
  	view.views = []