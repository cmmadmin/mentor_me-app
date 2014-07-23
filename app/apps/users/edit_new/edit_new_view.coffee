@MM.module "UsersApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.ItemView extends Marionette.ItemView
    template: "users/edit_new/edit_new_layout"

    tagName: "form"

    triggers:
      "click button" : "registerClicked"

    registerClicked: ->
      App.vent.trigger "user:register:clicked"
