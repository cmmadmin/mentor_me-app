@MM.module "Views.Lifelist", (Lifelist, App, Backbone, Marionette, $, _) ->

  class Lifelist.EditItemView extends Marionette.ItemView
    template: 'templates/lifelist/EditItem'

    itemView: EditItemView

    ui:
      checkbox: 'label.checkbox input'


    initialize: (options) ->
      @selected = options.selected
      @model.set('selected', @selected)

    onShow: ->
      @binding = rivets.bind @$el,
        item: @model

      # if @selected
      #   @ui.checkbox.attr('checked', 'checked')