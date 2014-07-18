@MM.module "JournalApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.ItemView extends App.Views.ItemView
    template: "mentees/journal/new/new_layout"

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

      
    # content = $('#add-journal-textarea').val()
    # datetime = $('#add-journal-datetime').val()