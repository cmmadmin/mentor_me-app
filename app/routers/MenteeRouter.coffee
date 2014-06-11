@MM.module "Routers", (Routers, App, Backbone, Marionette, $, _) ->
  MenteeController = App.Controllers.MenteeController

  class Routers.MenteeRouter extends Marionette.AppRouter
    appRoutes:
      # 'mentees' : 'mentees'
      #'mentees/:id' : 'menteeOverview'
      'mentees/:id/journal' : 'menteeJournal'
      # 'mentees/:id/journal_entries/:journal_id' : 'editJournalEntry'

      'mentees/:id/selfassess' : 'menteeSelfAssess'
      'mentees/:id/interview' : 'menteeInterview'
      'mentees/:id/observations' : 'menteeObservations'

      'mentees/:id/lifelist' : 'menteeLifelist'
      'mentees/:id/develop' : 'menteeDevelop'

  App.addInitializer ->
    console.log "router created"
    new Routers.MenteeRouter(controller: new MenteeController())