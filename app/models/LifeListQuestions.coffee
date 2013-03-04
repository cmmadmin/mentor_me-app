Questions = require('./Questions')

module.exports = class LifeListQuestions extends Backbone.Subset
  constructor: (@questions) ->
    super

  parent: ->
    return @questions

  sieve: (question) ->
    return question.get('develop_category') == 'lifelist'