@MM.module "DevelopApp.LifeList", (LifeList, App, Backbone, Marionette, $, _) ->

  class LifeList.Goal extends App.Views.ItemView
    template: 'develop/lifelist/goal'
    className: 'item item-dark item-text-wrap item-checkbox'

  class LifeList.Category extends App.Views.CompositeView
    template: 'develop/lifelist/category'
    itemViewContainer: '.develop-goals'
    itemView: LifeList.Goal

    ui:
      accordionToggle: 'h3.accordion-toggle'
      accordionBody: '.accordion-body'
      goals: '.develop-goals'

    events:
      'click @ui.accordionToggle' : 'toggleBody'

    initialize: ->
      @collection = @model.develop_goals()

    toggleBody: ->
      newHeight = if (@ui.accordionBody.height() > 0) then 0 else @ui.goals.height()
      @ui.accordionBody.height(newHeight)

  class LifeList.Categories extends App.Views.CollectionView
    itemView: LifeList.Category
    className: 'padded-page'