###
 * Backbone Primary Router
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

MM = require( 'MentorMe' )

Mentee = require('models/Mentee')
MenteeCollection = require('models/MenteeCollection')
MenteeView = require('views/MenteeView')
EditMenteeView = require('views/EditMenteeView')
JournalView = require('views/JournalView')
JournalEntryCollection = require 'models/JournalEntryCollection'
DevelopView = require('views/DevelopView')

module.exports = class Router extends Marionette.AppRouter

  ###//--------------------------------------
    //+ Routes
    //--------------------------------------###
    
  appRoutes:
        '' : 'home'
        'login': 'login'
        'mentees/:id' : 'menteeOverview'
        'mentees/:id/edit' : 'menteeEdit'
        'mentees/:id/journal' : 'menteeJournal'
        'mentees/:id/journal_entries' : 'menteeJournal'
        # 'mentees/:id/journal_entries/:journal_id' : 'editJournalEntry'
        'mentees/:id/tools' : 'menteeTools'
        'mentees/:id/snapshot' : 'menteeSnapshot'
        'mentees/:id/develop' : 'menteeDevelop'
        'mentees/:id/lifelist' : 'menteeLifelist'
        
  initialize: ->
    @firstPage = true

  ###//--------------------------------------
  //+ Route Handlers
  //--------------------------------------###

  