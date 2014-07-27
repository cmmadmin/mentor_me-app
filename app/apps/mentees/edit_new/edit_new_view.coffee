@MM.module "MenteesApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.ItemView extends App.Views.ItemView
    template: "mentees/edit_new/edit_new_layout"

    tagName: "form"
    className: "padded-page"

    onRender: ->
      @binder = rivets.bind @$el, mentee: @model

    onClose: ->
      if @binder
        @binder.unbind()

    templateHelpers:
      pageTitle: ->
        (if @model.isNew() then "New" else "Edit") + " Contact"

    events:
      "submit": 'preventSubmission'

    preventSubmission: (e) ->
      e.preventDefault()
      @trigger "form:submit"
