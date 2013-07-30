Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class Question extends Model
  urlRoot: Collection.serverUrl('questions')

  serializeAnswer: (profile) ->
    serialized = {}
    answer = profile.answers().findWhere(question_id: @id)
    serialized[@id] = answer.value() if answer
    return serialized

# Put at bottom to avoid circular dependency (ugly commonjs exports hack)
Answers = require('collections/Answers')
QuestionGroup = require('./QuestionGroup')

Question.has().many('answers', 
  collection: Answers
  inverse: 'question'
)

Question.has().one('question_group', 
  model: QuestionGroup
  inverse: 'questions'
)

