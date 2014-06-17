@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DevelopCategory extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('develop_categories')

  class Entities.DevelopCategoriesCollection extends Entities.Collection
    model: Entities.DevelopCategory

    url: Entities.Collection.serverUrl('develop_categories')


  Entities.on "before:start", ->
    # Supermodel definitions
    Entities.DevelopCategory.has().many('develop_goals',
        collection: Entities.DevelopGoalsCollection
        inverse: 'develop_category'
    )