###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.HomePage extends Marionette.Layout

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
    template: 'templates/HomePage'

    regions:
      menteeListRegion: "#mentee-list"


    initialize: ->
      super
      @mentees = @options.mentees

    onRender: ->
      @menteeListRegion.show(new Views.MenteeListView(collection: @mentees))