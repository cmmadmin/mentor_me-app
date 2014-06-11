@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Menu extends App.Models.Supers.Model

  class Entities.MenusCollection extends App.Collections.Supers.Collection
    model: Entities.Menu

    #chooseByName: (menu) ->
    #  @choose (@findWhere(name: menu) or @first())

    #@include "SingleChooser"

  API =
    getMenus: ->
      new Entities.MenusCollection [
        { name: "Snap Shot", icon: "icon ion-camera" }
        { name: "Develop", icon: "ion-android-note" }
        { name: "Journal", icon: "ion-android-book" }
      ]

  App.reqres.setHandler "menu:entities", ->
    API.getMenus()