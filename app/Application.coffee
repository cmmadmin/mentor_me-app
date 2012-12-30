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

Application = 

    ###//--------------------------------------
    //+ PUBLIC PROPERTIES / CONSTANTS
    //--------------------------------------###

    ###//--------------------------------------
    //+ INHERITED / OVERRIDES
    //--------------------------------------###

    initialize: ->

        # Import views
        HomePage = require('views/HomePage')
        Router = require('routers/Router')

        # Initialize views
        @homePage = new HomePage()
        @router = new Router()

        Object.freeze? this

module.exports = Application
