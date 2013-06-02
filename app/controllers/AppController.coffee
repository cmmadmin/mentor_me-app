MM = require('MentorMe')

Mentee = require('models/Mentee')
MenteeCollection = require('models/MenteeCollection')
MenteeView = require('views/MenteeView')
EditMenteeView = require('views/EditMenteeView')
JournalView = require('views/JournalView')
JournalEntryCollection = require 'models/JournalEntryCollection'
DevelopView = require('views/DevelopView')

module.exports = class AppController extends Marionette.Controller

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

  menteeSnapshot: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @changePage new DevelopView(model: mentee, type: 'snapshot')

  menteeDevelop: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @changePage new DevelopView(model: mentee, type: 'develop')

  menteeLifelist: (id) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @changePage new DevelopView(model: mentee, type: 'lifelist')

  ###//---------------------------------------
  //+ Utilities
  //---------------------------------------###

  loadMenteeView: (id, view) ->
    mentee = MM.collections.mentees.getOrFetch(id)
    @changePage new view({model: mentee})

  refreshCurrentPage: ->
    @currentPage.render()
    
  changePage: (page) ->
    # page.render()
      #page.$el.trigger('pagecreate');

    MM.appLayout.mainRegion.show(page)
    #transition = $.mobile.defaultPageTransition
    # TODO: Optimize and fix transitions
    #transition = 'none'
    # We don't want to slide the first page
    if @firstPage
      transition = 'none'
      @firstPage = false
    else
      #$.jQTouch.goTo(page.$el, 'slideleft', @currentPage?.$el)

    # if @currentPage
    #   @currentPage.remove();

    @currentPage = page;
    
    #page.$el.addClass('slideleft in current');
    #$.mobile.changePage($(page.el), {changeHash:false, transition: transition})
    