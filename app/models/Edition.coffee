@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.Edition extends Model
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

  Models.on "before:start", ->
    # Supermodel definitions
    Models.Edition.has().many('mentee_profiles', 
      collection: App.Collections.MenteeProfiles
      inverse: 'edition'
    )

    Models.Edition.has().many('surveys', 
      collection: App.Collections.Surveys
      inverse: 'edition'
    )
    Models.Edition.has().one('lifelist',
      model: Models.Lifelist
      inverse: 'edition'
    )