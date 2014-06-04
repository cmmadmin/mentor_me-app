@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class QuestionGroups extends Collection

    url: ->
      Collection.serverUrl('surveys') + '/' + @owner.id + '/question_groups'

    model: (attrs, options) ->
      QuestionGroup = require('models/QuestionGroup')
      return QuestionGroup.create(attrs, options)