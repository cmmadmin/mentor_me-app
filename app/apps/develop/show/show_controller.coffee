@MM.module "DevelopApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Slides =
    0: 'lifelist'
    1: 'suggestedsteps'
    2: 'plan'

  class Show.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
        onTap: _.bind(@saveDevelop, @)
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'develop'
      ]
    initialize: (options) ->
      { id } = options
      @layout = @getLayoutView()

      @model = App.request "mentees:entity", id 
      @categories = App.request("develop_category:entities").where(edition_id: @model.active_profile().get('edition_id'))
      @categories = new App.Entities.DevelopCategoriesCollection @categories

      @setupChosen()

      @listenTo @layout, "show", =>
        @lifeListRegion()
        @suggestedStepsRegion()
        @planRegion()

      @listenTo @layout, "slidechanged", (slide) =>
        @saveDevelop()
        # App.vent.trigger "develop:slidechanged", slide
      @listenTo App.vent, "app:pause", @saveDevelop

      @show @layout

    saveDevelop: ->
      # Get ids of chosen goals and items
      chosen_goals = (new App.Entities.DevelopGoalsCollection(App.Entities.DevelopGoal.all().models)).getChosenIds().sort()
      chosen_items = (new App.Entities.DevelopItemsCollection(App.Entities.DevelopItem.all().models)).getChosenIds().sort()
      active_profile = @model.active_profile()
      # Get old ids in profiles
      old_goals = active_profile.get('develop_goal_ids').sort()
      old_items = active_profile.get('develop_item_ids').sort()
      # Check if there is a difference
      goal_diff = !_.isEqual(chosen_goals, old_goals)
      item_diff = !_.isEqual(chosen_items, old_items)
      if(goal_diff)
        active_profile.set('develop_goal_ids', chosen_goals)
      if(item_diff)
        active_profile.set('develop_item_ids', chosen_items)
      # If so save the new selections to the DB
      if goal_diff || item_diff
        active_profile.save()
      

    getLayoutView: ->
      new Show.Layout

    lifeListRegion: ->
      new App.DevelopApp.LifeList.Controller
        region: @layout.lifeListRegion
        categories: @categories

    suggestedStepsRegion: ->
      new App.DevelopApp.SuggestedSteps.Controller
        region: @layout.stepsRegion
        categories: @categories

    planRegion: ->
      new App.DevelopApp.Plan.Controller
        region: @layout.planRegion

    setupChosen: ->
      profile = @model.active_profile()
      # Chooose goals based on profile develop_goal_ids
      goals = (new App.Entities.DevelopGoalsCollection(App.Entities.DevelopGoal.all().models))
      goals.clearChosen()
      goals.chooseByIds profile.get('develop_goal_ids'), chooseNone: true

      # Choose items based on profile develop_item_ids
      items = (new App.Entities.DevelopItemsCollection(App.Entities.DevelopItem.all().models))
      items.clearChosen()
      items.chooseByIds profile.get('develop_item_ids'), chooseNone: true
