Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class Answer extends Model
  urlRoot: Collection.serverUrl('answers')

  value: ->
    question() && @.get(question.get('question_type') + '_value')


MenteeProfile = require('./MenteeProfile')
Question = require('./Question')
# Supermodel definitions
Answer.has().one('mentee_profile', 
  model: MenteeProfile
  inverse: 'answers'
)

Answer.has().one('question', 
  model: Question
  inverse: 'answers'
)