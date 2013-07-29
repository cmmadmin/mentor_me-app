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

  initStateMachines: ->
    _.defaults()
    @state.snapshot = new SnapshotFsm(profile: @, initialState: @get('snapshot_state') || 'untapped')
    @state.develop = new DevelopFsm(profile: @, initialState: @get('develop_state') || 'disabled')
    @state.lifelist = new LifeListFsm(profile: @, initialState: @get('lifelist_state') || 'disabled')

  cleanup: ->
    _.each @state, (tool, key) =>
      tool.close()
      @state[key] = null

  snapshotProgress: ->
    scores = @edition().snapshotSurveys().map (survey) =>
      survey.profileProgress @
    answeredCount = _.reduce scores, (memo, score) -> (if memo.answers? then memo.answers else memo) + score.answers
    questionCount = _.reduce(scores, (memo, score) -> (if memo.questions? then memo.questions else memo) + score.questions)
    return Math.round(100 * answeredCount / questionCount);

  
Mentee = require('models/Mentee')
Edition = require('models/Edition')
Answers = require('collections/Answers')
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

