@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DevelopGoal extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('develop_goals')

  class Entities.DevelopGoalsCollection extends Entities.Collection
    model: Entities.DevelopGoal

    url: Entities.Collection.serverUrl('develop_goals')

    @include "MultiChooser"

    clearChosen: ->
      @each (goal) ->
        goal.unchoose()

  class Entities.ChosenDevelopGoalsCollection extends Backbone.Subset
    liveupdate_keys: 'all'
    sieve: (goal) ->
      goal.isChosen()

  Entities.on "before:start", ->
    # Supermodel definitions
    Entities.DevelopGoal.has().one('develop_curriculum',
        model: Entities.DevelopCurriculum
        inverse: 'develop_goals'
    )
    Entities.DevelopGoal.has().one('develop_category',
        model: Entities.DevelopCategory
        inverse: 'develop_goals'
    )
    Entities.DevelopGoal.has().many('develop_items',
        collection: Entities.DevelopItemsCollection
        inverse: 'develop_goal'
    )