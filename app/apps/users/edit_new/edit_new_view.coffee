@MM.module "UsersApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.ItemView extends App.Views.ItemView
    template: "users/edit_new/edit_new_layout"

    tagName: "form"

    onRender: ->
      @binder = rivets.bind @$el, user: @model

    onClose: ->
      if @binder
        @binder.unbind()

    templateHelpers:
      pageTitle: ->
        if @model.isNew() then "Register" else "Edit"

      buttonText: ->
        if @model.isNew() then "Register" else "Save"

    triggers:
      "submit form" : "user:register:clicked"
