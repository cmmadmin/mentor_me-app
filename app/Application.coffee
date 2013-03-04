###//CoffeeScript///////////////////////////////////////////////////////////////////
// 
// Copyright 2012 
// 
/////////////////////////////////////////////////////////////////////////////////###

###
 * Application Bootstrapper
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

MentorMe = 

  ###//--------------------------------------
  //+ PUBLIC PROPERTIES / CONSTANTS
  //--------------------------------------###

  # Event Mediator
  vent: _.extend({}, Backbone.Events)

  currentUser: null

  loginOpen: false

  ###//--------------------------------------
  //+ INHERITED / OVERRIDES
  //--------------------------------------###

  initialize: ->

    # Import views
    HomePage = require('views/HomePage')
    LoginPanel = require('views/LoginView')
    Router = require('routers/Router')

    #Import collections
    MenteeCollection = require('models/MenteeCollection')
    Questions = require('models/Questions')
    SnapshotQuestions = require('models/SnapshotQuestions')
    DevelopQuestions = require('models/DevelopQuestions')
    LifeListQuestions = require('models/LifeListQuestions')

    # Initialize collections
    @collections = 
      mentees: new MenteeCollection()
      questions: new Questions()

    # TODO: Use proper server bootstrap
    # Bootstrap initial data
    @collections.mentees.fetch();
    @collections.questions.fetch();
    @collections.snapshotQuestions = new SnapshotQuestions(@collections.questions)
    @collections.developQuestions = new DevelopQuestions(@collections.questions)
    @collections.lifelistQuestions = new LifeListQuestions(@collections.questions)

    # Initialize views
    @homePage = new HomePage(mentees: @collections.mentees)
    @loginPanel = new LoginPanel()
    @router = new Router()

    # TODO: Listen in better place
    @initEvents()

    Object.freeze? this

  initEvents: ->
    @vent.bind "authentication:logged_in", ->
      MentorMe.collections.mentees.fetch()
      MentorMe.router.navigate('/', true)
      $('#tbModal').one 'hidden', ->
        MentorMe.loginPanel.remove()
        MentorMe.loginOpen = false
      $('#tbModal').modal('hide');
    # @vent.bind 'mentee:addJournalEntry' (e, mentee, data) ->
    #   Mentee = require 'models/Mentee'
    #   JournalEntry = require 'models/JournalEntry'
    #   je = new JournalEntry()


module.exports = MentorMe
