MM = require('MentorMe')

Mentee = require('models/Mentee')
Mentees = require('collections/Mentees')
MenteeView = require('views/MenteeView')
EditMenteeView = require('views/EditMenteeView')
JournalView = require('views/JournalView')
JournalEntries = require 'collections/JournalEntries'
DevelopView = require('views/DevelopView')
SnapshotController = require('controllers/SnapshotController')
ProfileController = require('controllers/ProfileController')
HomePage = require('views/HomePage')

module.exports = class MenteeController extends Marionette.Controller

  mentees: ->
    @closeProfile();
    @changePage new HomePage(mentees: MM.collections.mentees)

  menteeOverview: (id) ->
    @loadMenteeView(id, MenteeView, actions: @getActions())

  menteeJournal: (id) ->
    col = new JournalEntries(mentee_id: id)
    col.fetch()
    @changePage new JournalView({collection: col})

  menteeSnapshot: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    profile = MM.request 'get:current:profile'
    snapshot = new SnapshotController(model: profile, region: MM.appLayout.mainRegion)

  menteeDevelop: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    @changePage new DevelopView(model: mentee, type: 'develop')

  menteeLifelist: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @updateProfile mentee
    @changePage new DevelopView(model: mentee, type: 'lifelist')


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