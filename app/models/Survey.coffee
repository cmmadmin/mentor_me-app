Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class Survey extends Model
  urlRoot: Collection.serverUrl('Surveys')


# Put at bottom to avoid circular dependency (ugly commonjs exports hack)
QuestionGroups = require('collections/QuestionGroups')
Edition = require('./Edition')
QuestionGroup = require('./QuestionGroup')

# relationships defined afterwards
Survey.has().one('edition', 
  model: Edition
  inverse: 'surveys'
)

Survey.has().many('question_groups', 
  collection: QuestionGroups
  inverse: 'survey'
)