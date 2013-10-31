Model = require('./supers/Model')
Collection = require('collections/supers/Collection')
SnapshotFsm = require('./state_machines/SnapshotFsm')
DevelopFsm = require('./state_machines/DevelopFsm')
LifeListFsm = require('./state_machines/LifeListFsm')


module.exports = class MenteeProfile extends Model
  urlRoot: Collection.serverUrl('mentee_profiles')

  defaults:
    snapshot_state: 'untapped'
    develop_state: 'disabled'
    lifelist_state: 'disabled'

  state:
    snapshot: null
    develop: null
    lifelist: null
    lifelist: null

  initStateMachines: ->
    _.defaults()
    @state.snapshot = new SnapshotFsm(profile: @, initialState: @get('snapshot_state') || 'untapped')
    @state.develop = new DevelopFsm(profile: @, initialState: @get('develop_state') || 'disabled')
    @state.lifelist = new LifeListFsm(profile: @, initialState: @get('lifelist_state') || 'disabled')

  cleanup: ->
    _.each @state, (tool, key) =>
      tool.close()
      @state[key] = null

  validate: ->
    @state.snapshot.validateState() if @state.snapshot != null
    @state.develop.validateState() if @state.develop != null
    @state.lifelist.validateState() if @state.lifelist != null

  snapshotProgress: ->
    scores = @edition().snapshotSurveys().map (survey) =>
      survey.profileProgress @
    answeredCount = _.reduce scores, (memo, score) -> (if memo.answers? then memo.answers else memo) + score.answers
    questionCount = _.reduce(scores, (memo, score) -> (if memo.questions? then memo.questions else memo) + score.questions)
    return Math.round(100 * answeredCount / questionCount);

  developProgress: ->
    survey = @edition().developSurvey()
    return survey.profileProgress(@).percentage

  saveAnswer: (question_id, value) ->
    Answer = require('./Answer')
    answer = @answers().findWhere(question_id: parseInt(question_id))
    if(answer)
      answer.setValue(value) if(answer.value().toString() != value) # We don't want to trigger a sync if value is the same
    else
      answer = Answer.create(question_id: question_id, mentee_profile_id: @.id)
      answer.setValue(value)

    answer.save() if answer.hasChanged()

  pickLifelistItem: (item) ->
    if !@lifelist_picks().getItems().contains(item)
      LifelistPick = require('./LifelistPick')
      pick = new LifelistPick(mentee_profile_id: @get('id'), lifelist_item_id: item.get('id'))
      pick.save()
  unpickLifelistItem: (item) ->
    picks = @lifelist_picks()
    if picks.getItems().contains(item)
      pick = picks.findWhere(lifelist_item_id: item.get('id'))
      pick.destroy() if pick
  
Mentee = require('models/Mentee')
Edition = require('models/Edition')
Answers = require('collections/Answers')
LifelistPicks = require('collections/LifelistPicks')
# relationships defined afterwards
MenteeProfile.has().one('mentee', 
  model: Mentee
  inverse: 'active_profile'
)
MenteeProfile.has().one('edition', 
  model: Edition
  inverse: 'mentee_profiles'
)
MenteeProfile.has().many('answers', 
  collection: Answers
  inverse: 'mentee_profile'
)
MenteeProfile.has().many('lifelist_picks',
  collection: LifelistPicks
  inverse: 'mentee_profile'
)

