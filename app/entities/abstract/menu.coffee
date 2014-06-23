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
        { name: "Snap Shot", icon: "icon ion-camera-empty icon-left", items: [
          { name: "Assess", description: "Self assessment performed by the mentee.", progress: "100%" }
          { name: "Explore", description: "Conversation ideas to explore together.", progress: "40%" }
          { name: "Observe", description: "Record long-term observations about the mentee here.", progress: "20%" }
        ] }
        { name: "Develop", icon: "icon ion-android-note", items: [
          { name: "Life List", description: "Choose aisles and shelves", progress: "40%" }
          { name: "Suggested Steps", description: "Choose cans", progress: "40%" }
          { name: "Plan", description: "View your plan and add custom cans", progress: "40%" }
        ] }
      ]

  App.reqres.setHandler "menu:entities", ->
    API.getMenus()