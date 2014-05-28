MM = require( 'MentorMe' )
MenteeController = require('controllers/MenteeController')

module.exports = class MenteeRouter extends Marionette.AppRouter
  appRoutes:
    'mentees' : 'mentees'
    'mentees/:id' : 'menteeOverview'
    'mentees/:id/journal' : 'menteeJournal'
    # 'mentees/:id/journal_entries/:journal_id' : 'editJournalEntry'

    'mentees/:id/snapshot' : 'menteeSnapshot'
    'mentees/:id/selfassess' : 'menteeSelfAssess'
    'mentees/:id/interview' : 'menteeInterview'
    'mentees/:id/observations' : 'menteeObservations'

    'mentees/:id/lifelist' : 'menteeLifelist'
    'mentees/:id/develop' : 'menteeDevelop'

MM.addInitializer ->
  console.log "router created"
  new MenteeRouter(controller: new MenteeController())