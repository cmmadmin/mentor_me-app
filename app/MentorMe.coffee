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
MentorMe = new Marionette.Application

  currentUser: null

  loginOpen: false

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

MentorMe.addInitializer ->
  # Import views
  HomePage = require('views/HomePage')
  LoginPanel = require('views/LoginView')
  Router = require('routers/Router')
  AppController = require('controllers/AppController')
  AppLayout = require('views/AppLayout')

  #Import collections
  Mentees = require('collections/Mentees')
  Questions = require('collections/Questions')

  # Initialize collections
  @collections = 
    mentees: new Mentees()
    questions: new Questions()

  # TODO: Use proper server bootstrap
  # Bootstrap initial data
  @collections.mentees.fetch();
  @collections.questions.fetch();

  # Initialize views
  @homePage = new HomePage(mentees: @collections.mentees)
  @loginPanel = new LoginPanel()
  @router = new Router(controller: new AppController())

  @appLayout = new AppLayout(el: "#mentor_me_app")
  # @appLayout.on "render", ->
  #   @mainRegion.show(MentorMe.homePage)

  # TODO: Listen in better place
  @initEvents()

  Object.freeze? this
MentorMe.addInitializer ->
  # Load helper for use in views
  require('helpers/ViewHelper')

  $(document).ajaxError (e, xhr, settings, exception) ->
    if (xhr.status == 401)
      application.router.login()

module.exports = MentorMe
