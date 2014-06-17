@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.DevelopCurriculum extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('develop_curriculums')

  class Entities.DevelopCurriculumsCollection extends Entities.Collection
    model: Entities.DevelopCurriculum

    url: Entities.Collection.serverUrl('develop_curriculums')


  Entities.on "before:start", ->
    # Supermodel definitions
    Entities.DevelopCurriculum.has().many('develop_goals',
        collection: Entities.DevelopGoalsCollection
        inverse: 'develop_curriculum'
    )
    Entities.DevelopCurriculum.has().many('develop_items',
        collection: Entities.DevelopItemsCollection
        inverse: 'develop_curriculum'
    )