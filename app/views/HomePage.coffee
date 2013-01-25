###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

View = require('./supers/View')
template = require('./templates/HomePage')
MenteeListView = require('./MenteeListView')
MenteeCollection = require('models/MenteeCollection')

module.exports = class HomePage extends View

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
    @$el.html( @template( @getRenderData() ) )
    @$('#mentee-list').html @menteeListView.el

    return @

  #
  # @private
  #
  getRenderData: ->
    return {
    }

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