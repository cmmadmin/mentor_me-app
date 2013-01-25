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

    # Initialize collections
    @collections = 
      mentees: new MenteeCollection()

    # TODO: Use proper server bootstrap
    # Bootstrap initial data
    @collections.mentees.fetch();

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
