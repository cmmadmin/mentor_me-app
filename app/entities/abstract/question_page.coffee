@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.QuestionPage extends App.Entities.Model
    questions: ->
      @get('questions')

    serializeAnswers: (profile) ->
      serialized = {}
      @questions().each (question) ->
        _.extend(serialized, question.serializeAnswer(profile))
      return serialized