@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.LifelistPick extends Model
    urlRoot: Collection.serverUrl('lifelist_picks')

  Models.on "before:start", ->
    # Supermodel definitions
    Models.LifelistPick.has().one('mentee_profile', 
      model: Models.MenteeProfile
      inverse: 'lifelist_picks'
    )

    Models.LifelistPick.has().one('lifelist_item', 
      model: Models.LifelistItem
      inverse: 'lifelist_picks'
    )