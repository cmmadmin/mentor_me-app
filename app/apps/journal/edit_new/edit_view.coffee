@MM.module "JournalApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.ItemView extends App.Views.ItemView
    template: "journal/edit_new/edit_new_layout"

    tagName: "form"

    onRender: ->
      @binder = rivets.bind @$el, model: @model

    onClose: ->
      if @binder
        @binder.unbind()

    triggers:
      "form submit" : "form:submit"