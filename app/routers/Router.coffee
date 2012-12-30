###
 * Backbone Primary Router
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

application = require( 'Application' )

module.exports = class Router extends Backbone.Router

  ###//--------------------------------------
    //+ Routes
    //--------------------------------------###
    
  routes:
        '' : 'home'
        
  initialize: ->
    @firstPage = true

  ###//--------------------------------------
  //+ Route Handlers
  //--------------------------------------###

  home: ->
    @changePage application.homePage
    
  changePage: (page) ->
    $(page.el).attr('data-role', 'page')
    page.render()
    $('body').append($(page.el))
    transition = $.mobile.defaultPageTransition
    # We don't want to slide the first page
    if @firstPage
      transition = 'none'
      @firstPage = false
    
    $.mobile.changePage($(page.el), {changeHash:false, transition: transition})
    
