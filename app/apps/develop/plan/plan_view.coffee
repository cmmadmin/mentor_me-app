@MM.module "DevelopApp.Plan", (Plan, App, Backbone, Marionette, $, _) ->

  class Plan.Item extends App.Views.ItemView
    template: 'develop/plan/item'
    className: 'item item-dark item-text-wrap'

    ui:
      accordionToggle: '.accordion-toggle'
      accordionBody: '.accordion-body'
      description: '.plan-item-description'

    events:
      'click @ui.accordionToggle' : 'toggleBody'

    toggleBody: ->
      @trigger 'category:toggled'
      newHeight = if (@ui.accordionBody.height() > 0) then 0 else @ui.description.height()
      @ui.accordionBody.height(newHeight)
      if @ui.accordionToggle.hasClass 'ion-plus'
        @ui.accordionToggle.removeClass 'ion-plus'
        @ui.accordionToggle.addClass 'ion-minus'
      else
        @ui.accordionToggle.removeClass 'ion-minus'
        @ui.accordionToggle.addClass 'ion-plus'

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