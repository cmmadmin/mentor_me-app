@MM.module "JournalApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.ItemView extends App.Views.ItemView
    template: "mentees/journal/edit/edit_layout"

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