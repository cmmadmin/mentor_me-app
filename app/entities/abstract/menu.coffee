@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.MenuItem extends App.Entities.Model

  class Entities.MenuItemsCollection extends App.Entities.Collection
    model: Entities.MenuItem

  class Entities.Menu extends App.Entities.Model

    initialize: ->
      items = this.get("items")
      if (items)
        this.items = new Entities.MenuItemsCollection(items)
        this.unset("items")

  class Entities.MenusCollection extends App.Entities.Collection
    model: Entities.Menu

    #chooseByName: (menu) ->
      #  @choose (@findWhere(name: menu) or @first())

    @include "SingleChooser"

  API =
    getMenus: ->
      new Entities.MenusCollection [
        { name: "Snap Shot", icon: "snapshot.png", items: [
          { name: "Assess", description: "Self assessment performed by the mentee.", surveyKey: "snapshot_self_assessment" }
          { name: "Explore", description: "Conversation ideas to explore together.", surveyKey: "snapshot_interactive" }
          { name: "Observe", description: "Record long-term observations about the mentee here.", surveyKey: "snapshot_observations" }
        ] }
        { name: "Develop", icon: "develop.png", items: [
          { name: "Life List", description: "Choose aisles and shelves", surveyKey: "snapshot_self_assessment" }
          { name: "Suggested Steps", description: "Choose cans", surveyKey: "snapshot_self_assessment" }
          { name: "Plan", description: "View your plan and add custom cans", surveyKey: "snapshot_self_assessment" }
        ] }
      ]

  App.reqres.setHandler "menu:entities", ->
    API.getMenus()