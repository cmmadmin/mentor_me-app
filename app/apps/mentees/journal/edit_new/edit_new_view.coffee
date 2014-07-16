@MM.module "JournalApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.ItemView extends App.Views.ItemView
    template: "mentees/journal/edit_new/edit_new_layout"

    tagName: "form"

    onRender: ->
      @binder = rivets.bind @$el, model: @model

    onClose: ->
      if @binder
        @binder.unbind()

    templateHelpers:
      pageTitle: ->
        (if @model.isNew() then "New" else "Edit") + " Entry"

    triggers:
      "click .submit" : "form:submit"