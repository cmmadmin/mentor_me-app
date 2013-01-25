###
 * Backbone Primary Router
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

MM = require( 'Application' )

Mentee = require('models/Mentee')
MenteeCollection = require('models/MenteeCollection')
MenteeView = require('views/MenteeView')
EditMenteeView = require('views/EditMenteeView')
JournalView = require('views/JournalView')
JournalEntryCollection = require 'models/JournalEntryCollection'

module.exports = class Router extends Backbone.Router

  ###//--------------------------------------
    //+ Routes
    //--------------------------------------###
    
  routes:
        '' : 'home'
        'login': 'login'
        'mentees/:id' : 'menteeOverview'
        'mentees/:id/edit' : 'menteeEdit'
        'mentees/:id/journal' : 'menteeJournal'
        
  initialize: ->
    @firstPage = true

  ###//--------------------------------------
  //+ Route Handlers
  //--------------------------------------###

  home: ->
    @changePage MM.homePage

  login: ->
    return if MM.loginOpen
    MM.loginOpen = true
    $('#tbModal').append(MM.loginPanel.$el)
    MM.loginPanel.render().delegateEvents()
    $('#tbModal').modal('show')

  menteeOverview: (id) ->
    @loadMenteeView id, MenteeView

  menteeEdit: (id) ->
    @loadMenteeView id, EditMenteeView

  menteeJournal: (id) ->
    col = new JournalEntryCollection(mentee_id: id)
    col.fetch()
    @changePage new JournalView({collection: col})

  ###//---------------------------------------
  //+ Utilities
  //---------------------------------------###

  loadMenteeView: (id, view) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @changePage new view({model: mentee})

  refreshCurrentPage: ->
    @currentPage.render()
    
  changePage: (page) ->
    page.$el.attr('data-role', 'page')
    page.$el.one 'pagebeforeshow', ->
    page.render()
      #page.$el.trigger('pagecreate');

    $('body').append(page.$el)
    #transition = $.mobile.defaultPageTransition
    # TODO: Optimize and fix transitions
    #transition = 'none'
    # We don't want to slide the first page
    if @firstPage
      transition = 'none'
      @firstPage = false
    else
      #$.jQTouch.goTo(page.$el, 'slideleft', @currentPage?.$el)

    if @currentPage
      @currentPage.remove();

    @currentPage = page;
    
    #page.$el.addClass('slideleft in current');
    #$.mobile.changePage($(page.el), {changeHash:false, transition: transition})
    
