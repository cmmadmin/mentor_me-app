###
 * Backbone Primary Router
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

application = require( 'Application' )

Mentee = require('models/Mentee')
MenteeCollection = require('models/MenteeCollection')
MenteeView = require('views/MenteeView')
EditMenteeView = require('views/EditMenteeView')

module.exports = class Router extends Backbone.Router

  ###//--------------------------------------
    //+ Routes
    //--------------------------------------###
    
  routes:
        '' : 'home'
        'mentees/:id' : 'menteeOverview'
        'mentees/:id/edit' : 'menteeEdit'
        
  initialize: ->
    @firstPage = true

  ###//--------------------------------------
  //+ Route Handlers
  //--------------------------------------###

  home: ->
    @changePage application.homePage

  menteeOverview: (id) ->
    @loadMenteeView id, MenteeView

  menteeEdit: (id) ->
    @loadMenteeView id, EditMenteeView

  ###//---------------------------------------
  //+ Utilities
  //---------------------------------------###

  loadMenteeView: (id, view) ->
    mentee = application.collections.mentees.getOrFetch(id)
    @changePage new view({model: mentee})
    
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
      @currentPage.$el.remove();

    @currentPage = page;
    
    #page.$el.addClass('slideleft in current');
    #$.mobile.changePage($(page.el), {changeHash:false, transition: transition})
    
