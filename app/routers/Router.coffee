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
    application.homePage.mentees.fetch()
    

  menteeOverview: (id) ->
    @loadMenteeView id, MenteeView

  menteeEdit: (id) ->
    @loadMenteeView id, EditMenteeView

  ###//---------------------------------------
  //+ Utilities
  //---------------------------------------###

  loadMenteeView: (id, view) ->
    Backbone.sync("read", application.homePage.mentees)
    mentee = application.homePage.mentees.get(id)
    #mentee = new Mentee({id: id})
    @changePage new view({model: mentee})
    # mentee.fetch(
    #   success: (data) =>
    #     @changePage new view({model: data})
    # )
    
  changePage: (page) ->
    $(page.el).attr('data-role', 'page')
    page.render()
    $('body').append($(page.el))
    transition = $.mobile.defaultPageTransition
    # TODO: Optimize and fix transitions
    transition = 'none'
    # We don't want to slide the first page
    if @firstPage
      transition = 'none'
      @firstPage = false
    
    $.mobile.changePage($(page.el), {changeHash:false, transition: transition})
    
