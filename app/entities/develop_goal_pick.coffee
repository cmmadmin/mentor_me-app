@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DevelopGoalPick extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('develop_goal_picks')

  class Entities.DevelopGoalPicksCollection extends Entities.Collection
    model: Entities.DevelopGoalPick

    url: Entities.Collection.serverUrl('develop_goal_picks')


  Entities.on "before:start", ->
    # Supermodel definitions
    Entities.DevelopGoalPick.has().one('mentee_profile',
        model: App.Models.MenteeProfile
        inverse: 'develop_goal_picks'
    )
    Entities.DevelopGoalPick.has().one('develop_goal',
        model: Entities.DevelopGoal
        inverse: 'mentee_profile_picks'
    )