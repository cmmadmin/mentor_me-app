Collection = require('./supers/Collection')

module.exports = class Questions extends Collection

  url: ->
    Collection.serverUrl('question_groups') + '/' + @owner.id + '/questions'
  
  initialize: ->
    #@storage = new Offline.Storage('questions', this)
    super

  model: (attrs, options) ->
    Question = require('models/Question')
    return Question.create(attrs, options)