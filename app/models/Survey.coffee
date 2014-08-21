@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.Survey extends Model
    urlRoot: Collection.serverUrl('Surveys')

    default_question_group: ->
      @question_groups().get(@get('default_question_group_id'))

    questions: ->
      _.flatten(_.map(@question_groups().models, (group) ->
        group.questions().models
      ))

    surveyProgress: (profile) ->
      questions = @questions()
      progress = {}
      progress.questions = questions.length
      progress.answers = 0
      _.each questions, (question) ->
        if question.answers().length > 0
          if question.answers().some((answer) -> answer.mentee_profile() is profile)
            progress.answers += 1
      progress.percentage = Math.round(100 * progress.answers / progress.questions)
      return progress.percentage

    profileProgress: (profile) ->
      questions = @questions()
      progress = {}
      progress.questions = questions.length
      progress.answers = 0
      _.each questions, (question) ->
        if question.answers().length > 0
          if question.answers().some((answer) -> answer.mentee_profile() is profile)
            progress.answers += 1
      progress.percentage = Math.round(100 * progress.answers / progress.questions)
      return progress.percentage

  Models.on "before:start", ->
    Models.Survey.has().one('edition', 
      model: Models.Edition
      inverse: 'surveys'
    )

    Models.Survey.has().many('question_groups', 
      collection: App.Collections.QuestionGroups
      inverse: 'survey'
    )