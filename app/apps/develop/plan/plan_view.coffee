@MM.module "DevelopApp.Plan", (Plan, App, Backbone, Marionette, $, _) ->

  class Plan.Item extends App.Views.ItemView
    template: 'develop/plan/item'
    className: 'item item-dark item-text-wrap'

  class Plan.Empty extends App.Views.ItemView
    template: 'develop/plan/empty'
    className: 'padded-page text-center'

  class Plan.Items extends App.Views.CollectionView
    itemView: Plan.Item
    emptyView: Plan.Empty
    className: 'list'

  class Plan.Layout extends App.Views.Layout
    template: "develop/plan/layout"
    className: 'full-page'

    regions:
      itemsRegion: "#items-region"
      customItemRegion: "#custom-item-region"