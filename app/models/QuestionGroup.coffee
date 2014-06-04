@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.QuestionGroup extends Model
    urlRoot: Collection.serverUrl('question_groups')

    serializeAnswers: (profile) ->
      serialized = {}
      @questions().each (question) ->
        _.extend(serialized, question.serializeAnswer(profile))
      return serialized

  App.on "initialize:before", ->
    Models.QuestionGroup.has().one('survey', 
      model: Models.Survey
      inverse: 'question_groups'
    )

    Models.QuestionGroup.has().many('questions', 
      collection: App.Collections.Questions
      inverse: 'question_group'
    )

