@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DevelopItem extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('develop_items')

  class Entities.DevelopItemsCollection extends Entities.Collection
    model: Entities.DevelopItem

    url: Entities.Collection.serverUrl('develop_items')


  Entities.on "before:start", ->
    # Supermodel definitions
    Entities.DevelopItem.has().one('develop_curriculum',
        model: Entities.DevelopCurriculum
        inverse: 'develop_goals'
    )
    Entities.DevelopItem.has().one('develop_goal',
        model: Entities.DevelopGoal
        inverse: 'develop_items'
    )
