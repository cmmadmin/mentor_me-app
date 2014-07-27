@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection
  SnapshotFsm = Models.StateMachines.SnapshotFsm
  DevelopFsm = Models.StateMachines.DevelopFsm
  LifeListFsm = Models.StateMachines.LifeListFsm

  class Models.MenteeProfile extends Model
    urlRoot: Collection.serverUrl('mentee_profiles')

    defaults:
      snapshot_state: 'untapped'

    state:
      snapshot: null
      develop: null
      lifelist: null
      lifelist: null

    initStateMachines: ->
      _.defaults()
      @state.snapshot = new SnapshotFsm(profile: @, initialState: @get('snapshot_state') || 'untapped')

    cleanup: ->
      _.each @state, (tool, key) =>
        tool.close()
        @state[key] = null

    validate: ->
      @state.snapshot.validateState() if @state.snapshot != null

    snapshotProgress: ->
      scores = @edition().snapshotSurveys().map (survey) =>
        survey.profileProgress @
      answeredCount = _.reduce scores, (memo, score) -> (if memo.answers? then memo.answers else memo) + score.answers
      questionCount = _.reduce(scores, (memo, score) -> (if memo.questions? then memo.questions else memo) + score.questions)
      return Math.round(100 * answeredCount / questionCount);

    saveAnswer: (question_id, value) ->
      Answer = Models.Answer
      answer = @answers().findWhere(question_id: parseInt(question_id))
      if(answer)
        answer.setValue(value) if(answer.value().toString() != value) # We don't want to trigger a sync if value is the same
      else
        answer = Answer.create(question_id: question_id, mentee_profile_id: @.id)
        answer.setValue(value)

      answer.save() if answer.hasChanged()
    
  Models.on "before:start", ->
    Models.MenteeProfile.has().one('mentee', 
      model: Models.Mentee
      inverse: 'active_profile'
    )
    Models.MenteeProfile.has().one('edition', 
      model: Models.Edition
      inverse: 'mentee_profiles'
    )
    Models.MenteeProfile.has().many('answers', 
      collection: App.Collections.Answers
      inverse: 'mentee_profile'
    )
