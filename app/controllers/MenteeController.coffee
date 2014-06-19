@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  Mentee = App.Models.Mentee
  Mentees = App.Collections.Mentees

  class Controllers.MenteeController extends Marionette.Controller
    Views = App.Views
    mentees: ->
      @closeProfile();
      @changePage new Views.HomePage(mentees: MM.collections.mentees)

    menteeOverview: (id) ->
      @loadMenteeView(id, Views.MenteeView)

    menteeJournal: (id) ->
      mentee = MM.collections.mentees.getOrFetch(id)
      journal_entries = mentee.journal_entries()
      journal_entries.fetch()
      @changePage new Views.JournalView({collection: journal_entries})

    menteeSnapshot: (id) ->
      mentee = MM.collections.mentees.getOrFetch(id)
      @updateProfile mentee
      profile = MM.request 'get:current:profile'
      snapshot = new Controllers.SnapshotController(model: profile, region: MM.appLayout.mainRegion)

    menteeSelfAssess: (id) ->
      mentee = MM.collections.mentees.getOrFetch(id)
      @updateProfile mentee
      profile = MM.request 'get:current:profile'
      snapshot = new Controllers.SelfAssessController(model: profile, region: MM.appLayout.mainRegion)

    menteeInterview: (id) ->
      mentee = MM.collections.mentees.getOrFetch(id)
      @updateProfile mentee
      profile = MM.request 'get:current:profile'
      snapshot = new Controllers.InterviewController(model: profile, region: MM.appLayout.mainRegion)

    menteeObservations: (id) ->
      mentee = MM.collections.mentees.getOrFetch(id)
      @updateProfile mentee
      profile = MM.request 'get:current:profile'
      snapshot = new Controllers.ObservationsController(model: profile, region: MM.appLayout.mainRegion)

    loadMenteeView: (id, view, options = {}) ->
      mentee = MM.collections.mentees.getOrFetch(id)
      @updateProfile mentee
      @changePage new view(_.extend({model: mentee}, options))

    changePage: (page) ->
      MM.appLayout.mainRegion.show(page)



    getActions: ->