Model = require('./supers/Model')
Collection = require('collections/supers/Collection')

module.exports = class Edition extends Model
  urlRoot: Collection.serverUrl('editions')

  snapshotSelfAssessmentSurvey: ->
    @surveys().get(@get('snapshot_self_assessment_survey_id'))
  snapshotInteractiveSurvey: ->
    @surveys().get(@get('snapshot_interactive_survey_id'))
  snapshotObservationsSurvey: ->
    @surveys().get(@get('snapshot_observations_survey_id'))
  developSurvey: ->
    @surveys().get(@get('develop_survey_id'))

  snapshotSurveys: ->
    new Backbone.Collection([@snapshotSelfAssessmentSurvey(), @snapshotInteractiveSurvey(),
      @snapshotObservationsSurvey()]);

# Put at bottom to avoid circular dependency (ugly commonjs exports hack)
MenteeProfiles = require('collections/MenteeProfiles')
Surveys = require('collections/Surveys')

# Supermodel definitions
Edition.has().many('mentee_profiles', 
  collection: MenteeProfiles
  inverse: 'edition'
)

Edition.has().many('surveys', 
  collection: Surveys
  inverse: 'edition'
)