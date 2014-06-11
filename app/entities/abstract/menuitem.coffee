@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.MenuItem extends App.Models.Supers.Model

  class Entities.MenuItemsCollection extends App.Collections.Supers.Collection
    model: Entities.MenuItem

  #chooseByName: (menu) ->
  #  @choose (@findWhere(name: menu) or @first())

  #@include "SingleChooser"

  API =
    getMenuItems: ->
      new Entities.MenusCollection [
        { name: "Assess", description: "Interdum et malesuada fames", progress: "100%" }
        { name: "Explore", description: "Nunc suscipit volutpat velit non", progress: "40%" }
        { name: "Observe", description: "Vivamus mauris eros", progress: "20%" }
      ]

  App.reqres.setHandler "menuitems:entities", ->
    API.getMenuItems()
