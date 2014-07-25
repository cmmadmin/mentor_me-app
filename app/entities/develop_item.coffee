@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DevelopItem extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('develop_items')

  class Entities.DevelopItemsCollection extends Entities.Collection
    model: Entities.DevelopItem

    url: Entities.Collection.serverUrl('develop_items')

    @include "MultiChooser"

  class Entities.ChosenDevelopItemsCollection extends Backbone.Subset
    liveupdate_keys: 'all'
    sieve: (item) ->
      item.isChosen()

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

  API =
    getItems: ->
      Entities.DevelopItem.all()

  App.reqres.setHandler "develop_item:entities", ->
    API.getItems()