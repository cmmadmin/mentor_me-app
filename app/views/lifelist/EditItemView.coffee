MM = require( 'MentorMe' )
template = require('templates/lifelist/EditItem')

module.exports = class EditItemView extends Marionette.ItemView
  template: template

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