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

module.exports = class HomePage extends Marionette.Layout

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

  regions:
    menteeListRegion: "#mentee-list"


  initialize: -> 
    super
    @mentees = @options.mentees

  onRender: ->
    @menteeListRegion.show(new MenteeListView(collection: @mentees))