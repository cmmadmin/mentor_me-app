@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.Question extends Model
    urlRoot: Collection.serverUrl('questions')

    serializeAnswer: (profile) ->
      serialized = {}
      answer = profile.answers().findWhere(question_id: @id)
      serialized[@id] = answer.value() if answer
      return serialized


  App.on "initialize:before", ->
    Models.Question.has().many('answers', 
      collection: App.Collections.Answers
      inverse: 'question'
    )

    Models.Question.has().one('question_group', 
      model: Models.QuestionGroup
      inverse: 'questions'
    )
    