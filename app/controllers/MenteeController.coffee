MM = require('MentorMe')

Mentee = require('models/Mentee')
Mentees = require('collections/Mentees')
MenteeView = require('views/MenteeView')
EditMenteeView = require('views/EditMenteeView')
JournalView = require('views/JournalView')
JournalEntries = require 'collections/JournalEntries'
DevelopView = require('views/DevelopView')
SnapshotController = require('controllers/SnapshotController')
SelfAssessController = require('controllers/SelfAssessController')
InterviewController = require('controllers/InterviewController')
ObservationsController = require('controllers/ObservationsController')
DevelopController = require('controllers/DevelopController')
ProfileController = require('controllers/ProfileController')
LifelistController = require('controllers/LifelistController')
HomePage = require('views/HomePage')

module.exports = class MenteeController extends Marionette.Controller

  mentees: ->
    @closeProfile();
    @changePage new HomePage(mentees: MM.collections.mentees)

  menteeOverview: (id) ->
    @loadMenteeView(id, MenteeView)

  menteeJournal: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    journal_entries = mentee.journal_entries()
    journal_entries.fetch()
    @changePage new JournalView({collection: journal_entries})

  menteeSnapshot: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    profile = MM.request 'get:current:profile'
    snapshot = new SnapshotController(model: profile, region: MM.appLayout.mainRegion)

  menteeSelfAssess: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    profile = MM.request 'get:current:profile'
    snapshot = new SelfAssessController(model: profile, region: MM.appLayout.mainRegion)

  menteeInterview: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    profile = MM.request 'get:current:profile'
    snapshot = new InterviewController(model: profile, region: MM.appLayout.mainRegion)

  menteeObservations: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    profile = MM.request 'get:current:profile'
    snapshot = new ObservationsController(model: profile, region: MM.appLayout.mainRegion)

  menteeDevelop: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    profile = MM.request 'get:current:profile'
    develop = new DevelopController(model: profile, region: MM.appLayout.mainRegion)

  menteeLifelist: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    profile = MM.request 'get:current:profile'
    develop = new LifelistController(model: profile, region: MM.appLayout.mainRegion)


  loadMenteeView: (id, view, options = {}) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    @changePage new view(_.extend({model: mentee}, options))
    
  changePage: (page) ->
    MM.appLayout.mainRegion.show(page)
    
  updateProfile: (mentee) ->
    if profile = mentee.active_profile()
      @profileController or= new ProfileController(profile: profile)
      @profileController.setProfile(profile)
    else
      console.error("Data error: Mentee is missing an active profile")

  closeProfile: ->
    if @profileController
      @profileController.close();
      @profileController = null;

  getActions: ->