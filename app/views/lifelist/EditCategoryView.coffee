@MM.module "Views.Lifelist", (Lifelist, App, Backbone, Marionette, $, _) ->
  EditItemView = App.Views.EditItemView

  class Lifelist.EditCategoryView extends Marionette.CompositeView
    template: 'templates/lifelist/EditCategory'
    className: 'lifelist-group'

    itemView: EditItemView
    itemViewContainer: '.lifelistItems'

    initialize: (options) ->
      @selectedItems = options.selectedItems
      @collection = @model.itemsByLifelist(options.lifelist)

    itemViewOptions: (model, index) ->
      selected: @selectedItems.contains(model)