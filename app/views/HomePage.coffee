###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

template = require('templates/HomePage')
MenteeListView = require('./MenteeListView')
MenteeCollection = require('models/MenteeCollection')

module.exports = class HomePage extends Marionette.ItemView

  ###//--------------------------------------
  //+ PUBLIC PROPERTIES / CONSTANTS
  //--------------------------------------###

  #
  # @private
  #
  id: 'home-page'
  #
  # @private
  #
  template: template

  mentees: null

  ###//--------------------------------------
    //+ INHERITED / OVERRIDES
    //--------------------------------------###

  initialize: ->
    super
    @mentees = @options.mentees
    @menteeListView = new MenteeListView(collection: @mentees)
    
  #
  # @private
  #
  render: ->
    super
    @$('#mentee-list').html @menteeListView.el

    return @

  remove: ->
    @$el.detach()
    @stopListening()
    return @

  ###//--------------------------------------
  //+ PUBLIC METHODS / GETTERS / SETTERS
  //--------------------------------------###

  ###//--------------------------------------
  //+ EVENT HANDLERS
  //--------------------------------------###

  ###//--------------------------------------
  //+ PRIVATE AND PROTECTED METHODS
  //--------------------------------------###
