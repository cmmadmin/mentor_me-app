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
        @router = new Router()

        Object.freeze? this

module.exports = Application
