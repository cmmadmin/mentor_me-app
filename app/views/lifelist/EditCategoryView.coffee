MM = require( 'MentorMe' )
template = require('templates/lifelist/EditCategory')
EditItemView = require('./EditItemView')

module.exports = class EditCategoryView extends Marionette.CompositeView
  template: template
  className: 'lifelist-group'

  itemView: EditItemView
  itemViewContainer: '.lifelistItems'

  initialize: (options) ->
    @selectedItems = options.selectedItems
    @collection = @model.itemsByLifelist(options.lifelist)

  itemViewOptions: (model, index) ->
    selected: @selectedItems.contains(model)