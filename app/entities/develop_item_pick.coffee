@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DevelopItemPick extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('develop_item_picks')

  class Entities.DevelopItemPicksCollection extends Entities.Collection
    model: Entities.DevelopItemPick

    url: Entities.Collection.serverUrl('develop_item_picks')


  Entities.on "before:start", ->
    # Supermodel definitions
    Entities.DevelopItemPick.has().one('mentee_profile',
        model: App.Models.MenteeProfile
        inverse: 'develop_item_picks'
    )
    Entities.DevelopItemPick.has().one('develop_item',
        model: Entities.DevelopItem
        inverse: 'mentee_profile_picks'
    )