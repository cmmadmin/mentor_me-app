@MM.module "DevelopApp.SuggestedSteps", (SuggestedSteps, App, Backbone, Marionette, $, _) ->

  class SuggestedSteps.Item extends App.Views.ItemView
    template: 'develop/suggested_steps/item'
    className: 'item item-dark item-text-wrap item-checkbox'

    onRender: ->
      @binding = rivets.bind(@el, { model: @model })

    onClose: ->
      @binder.unbind() if @binder

  class SuggestedSteps.Goal extends App.Views.CompositeView
    template: 'develop/suggested_steps/goal'
    itemViewContainer: '.develop-items'
    itemView: SuggestedSteps.Item

    initialize: ->
      @collection = @model.develop_items()

  class SuggestedSteps.Category extends App.Views.CompositeView
    template: 'develop/suggested_steps/category'
    itemViewContainer: '.develop-goals'
    itemView: SuggestedSteps.Goal

    ui:
      accordionToggle: 'h3.accordion-toggle'
      accordionBody: '.accordion-body'
      goals: '.develop-goals'

    events:
      'click @ui.accordionToggle' : 'toggleBody'

    initialize: ->
      goals = @model.develop_goals()
      @collection = new App.Entities.ChosenDevelopGoalsCollection null,
        parent: -> 
          goals

      @listenTo @, "after:item:added item:removed", (args) ->
        if @ui.accordionBody.height() > 0
          newHeight = @ui.goals.height()
          @ui.accordionBody.height(newHeight)

    toggleBody: ->
      @trigger 'category:toggled'
      newHeight = if (@ui.accordionBody.height() > 0) then 0 else @ui.goals.height()
      @ui.accordionBody.height(newHeight)

  class SuggestedSteps.Categories extends App.Views.CollectionView
    itemView: SuggestedSteps.Category
    className: 'padded-page'