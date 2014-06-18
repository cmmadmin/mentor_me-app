@MM.module "MenteesApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.ItemView extends App.Views.ItemView
    template: "mentees/edit_new/edit_new_layout"

    onRender: ->
      @binder = rivets.bind @$el, model: @model

    onClose: ->
      if @binder
        @binder.unbind()

    templateHelpers:
      pageTitle: ->
        (if @model.isNew() then "New" else "Edit") + " Contact"

    triggers:
      "click .submit"                       : "form:submit"
      "click [data-form-button='cancel']" : "form:cancel"
