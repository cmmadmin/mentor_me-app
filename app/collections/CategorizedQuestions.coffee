Questions = require('models/Questions')

module.exports = class CategorizedQuestions extends Backbone.Subset
  constructor: (@questions, @develop_category) ->
    super

  parent: ->
    return @questions

  sieve: (question) ->
    return question.get('develop_category') == @develop_category