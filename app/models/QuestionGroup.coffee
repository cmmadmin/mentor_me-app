Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class QuestionGroup extends Model
  urlRoot: Collection.serverUrl('question_groups')

# Put at bottom to avoid circular dependency (ugly commonjs exports hack)
Questions = require('collections/Questions')
Survey = require('./Survey')

QuestionGroup.has().one('survey', 
  model: Survey
  inverse: 'question_groups'
)

QuestionGroup.has().many('questions', 
  collection: Questions
  inverse: 'question_group'
)

