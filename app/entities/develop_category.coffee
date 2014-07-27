@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DevelopCategory extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('develop_categories')

  class Entities.DevelopCategoriesCollection extends Entities.Collection
    model: Entities.DevelopCategory

    url: Entities.Collection.serverUrl('develop_categories')

  class Entities.ChosenDevelopCategoriesCollection extends Backbone.Subset
    # liveupdate_keys: 'chosen'
    sieve: (category) ->
      return true
      # We don't choose categories directly so what we really want to know is:
      # Does this category have any chosen goals?
      category.develop_goals().getChosen().length > 0


  Entities.on "before:start", ->
    # Supermodel definitions
    Entities.DevelopCategory.has().many('develop_goals',
        collection: Entities.DevelopGoalsCollection
        inverse: 'develop_category'
    )

  API =
    getCategories: ->
      Entities.DevelopCategory.all()

  App.reqres.setHandler "develop_category:entities", ->
    API.getCategories()