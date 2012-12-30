###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

View = require('./supers/View')
template = require('./templates/HomePageTemplate')
MenteeListView = require('./MenteeListView')

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

	###//--------------------------------------
  	//+ INHERITED / OVERRIDES
  	//--------------------------------------###

	#
   	# @private
	#
	initialize: ->
		@render = _.bind( @render, @ )
    #@menteeListView = new MenteeListView()
    
  #
   	# @private
	#
	render: ->
		@$el.html( @template( @getRenderData() ) )
    #@$('#mentee-list').html @menteeListView.render

		return @

	#
   	# @private
	#
	getRenderData: ->
		return {
			#content: "Application Content"
		}

	###//--------------------------------------
	//+ PUBLIC METHODS / GETTERS / SETTERS
	//--------------------------------------###

	###//--------------------------------------
	//+ EVENT HANDLERS
	//--------------------------------------###

	###//--------------------------------------
	//+ PRIVATE AND PROTECTED METHODS
	//--------------------------------------###
