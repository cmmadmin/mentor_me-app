@MM.module "DevelopApp.LifeList", (LifeList, App, Backbone, Marionette, $, _) ->

  class LifeList.Goal extends App.Views.ItemView
    template: 'develop/lifelist/goal'
    className: 'item item-dark item-text-wrap item-checkbox'
    tagName: 'li'

    onRender: ->
      @binding = rivets.bind(@el, { model: @model })

    onClose: ->
      @binder.unbind() if @binder

    ui:
      descriptionToggle: 'description-toggle'
      description: '.goal-description'

    events:
      'click @ui.descriptionToggle' : 'toggleDescription'

    toggleDescription: ->
      newHeight = if (@ui.description.height() > 0) then 0 else @ui.description.height()
      @ui.description.height(newHeight)

  class LifeList.Category extends App.Views.CompositeView
    template: 'develop/lifelist/category'
    itemViewContainer: 'ul.develop-goals'
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
      @trigger 'category:toggled'
      newHeight = if (@ui.accordionBody.height() > 0) then 0 else @ui.goals.height()
      @ui.accordionBody.height(newHeight)

  class LifeList.Categories extends App.Views.CollectionView
    itemView: LifeList.Category
    className: 'padded-page'

  class LifeList.Layout extends App.Views.Layout
    template: "develop/lifelist/layout"
    className: 'full-page'

    regions:
      accordionRegion: "#accordion-region"