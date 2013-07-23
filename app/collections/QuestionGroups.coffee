Collection = require('./supers/Collection')


module.exports = class QuestionGroups extends Collection

  url: Collection.serverUrl('question_groups')

  model: (attrs, options) ->
    QuestionGroup = require('models/QuestionGroup')
    return QuestionGroup.create(attrs, options)