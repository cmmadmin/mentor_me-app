@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class Collections.Questions extends Collection

    url: ->
      Collection.serverUrl('question_groups') + '/' + @owner.id + '/questions'

    initialize: ->
      #@storage = new Offline.Storage('questions', this)
      super

    model: (attrs, options) ->
      Question = require('models/Question')
      return Question.create(attrs, options)