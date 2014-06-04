###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->
  MenteeListView = Views.MenteeListView
  MenteeCollection = App.Collections.Mentees

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
      @menteeListRegion.show(new MenteeListView(collection: @mentees))