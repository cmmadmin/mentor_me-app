@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection
  LifelistItems = Collections.LifelistItems

  class Collections.LifelistPicks extends Collection

    url: ->
      Collection.serverUrl('mentee_profiles') + '/' + @owner.id + '/lifelist_picks'

    model: (attrs, options) ->
      LifelistPick = App.Models.LifelistPick
      return LifelistPick.create(attrs, options)
    getItems: ->
      items = @map (pick) ->
        pick.lifelist_item()
      return new LifelistItems(items)