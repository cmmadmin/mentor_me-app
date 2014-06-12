@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.MenuItem extends App.Models.Supers.Model

  class Entities.MenuItemsCollection extends App.Collections.Supers.Collection
    model: Entities.MenuItem

  class Entities.Menu extends App.Models.Supers.Model

    initialize: ->
      items = this.get("items")
      if (items)
        this.items = new Entities.MenuItemsCollection(items)
        this.unset("items")

  class Entities.MenusCollection extends App.Collections.Supers.Collection
    model: Entities.Menu

    initialize: ->
      new Backbone.SingleChooser(@)

  #chooseByName: (menu) ->
    #  @choose (@findWhere(name: menu) or @first())

    #@include "SingleChooser"

  API =
    getMenus: ->
      new Entities.MenusCollection [
        { name: "Snap Shot", icon: "icon ion-camera", items: [
          { name: "Assess", description: "Interdum et malesuada fames", progress: "100%" }
        ] }
        { name: "Develop", icon: "ion-android-note", items: [
          { name: "Explore", description: "Nunc suscipit volutpat velit non", progress: "40%" }
        ] }
        { name: "Journal", icon: "ion-android-book", items: [
          { name: "Observe", description: "Vivamus mauris eros", progress: "20%" }
        ] }
      ]

  App.reqres.setHandler "menu:entities", ->
    API.getMenus()