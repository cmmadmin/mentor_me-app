@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->
  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.Answer extends Model
    urlRoot: Collection.serverUrl('answers')

    value: ->
      @get(@question().get('question_type') + '_value')

    setValue: (val) ->
      @question() && @.set(@question().get('question_type') + '_value', val)
      
  App.on "initialize:before", ->
    # Supermodel definitions
    Models.Answer.has().one('mentee_profile',
      model: Models.MenteeProfile
      inverse: 'answers'
    )

    Models.Answer.has().one('question',
      model: Models.Question
      inverse: 'answers'
    )