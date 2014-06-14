@MM.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    show: (navItem) ->
      new HeaderApp.Show.Controller
        navItem: navItem
        region: App.headerRegion

  App.commands.setHandler "header:set:navItem", (navItem) ->
    if !navItem
      App.vent.trigger "header:hidden"
      App.headerRegion.close()
    else
      # TODO: Maybe there's a way to not recreate the controller each time?
      App.vent.trigger "header:shown"
      API.show navItem
      
  # HeaderApp.on "start", (navs) ->
  #   API.show()