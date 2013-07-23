Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class Answer extends Model
  urlRoot: Collection.serverUrl('answers')


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