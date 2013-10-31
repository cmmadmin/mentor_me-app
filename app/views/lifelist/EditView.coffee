MM = require( 'MentorMe' )
template = require('templates/lifelist/Edit')
EditItemView = require('./EditItemView')

module.exports = class EditView extends Marionette.CompositeView
  template: template
  className: 'lifelist-edit'

  itemView: EditItemView
  itemViewContainer: '.lifelistItems'
  
  events:
    'click #save-lifelist' : 'saveItems'

  initialize: (options) ->
    @selectedItems = options.selectedItems

  saveItems: ->
    @collection.each (item) =>
      if !item.get('selected') && @selectedItems.contains(item)
        @model.unpickLifelistItem item
      else if item.get('selected') && !@selectedItems.contains(item)
        @model.pickLifelistItem item
    @trigger('lifelist:edit:confirm:clicked')
    Backbone.history.navigate('mentees/' + @model.get('id'), true)

  itemViewOptions: (model, index) ->
    selected: @selectedItems.contains(model)