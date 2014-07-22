@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Prompt extends App.Entities.Model
    defaults: {
      page: "",
      title: "",
      content: ""
    }

  class Entities.PromptCollection extends App.Entities.Collection
    model: Entities.Prompt