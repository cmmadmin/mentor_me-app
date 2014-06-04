@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Questions = App.Models.Questions

  class Collections.CategorizedQuestions extends Backbone.Subset
    constructor: (@questions, @develop_category) ->
      super

    parent: ->
      return @questions

    sieve: (question) ->
      return question.get('develop_category') == @develop_category