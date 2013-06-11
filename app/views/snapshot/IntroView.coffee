###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
MM = require( 'MentorMe' )
template = require('templates/snapshot/Intro')

module.exports = class IntroView extends Marionette.ItemView
  template: template

  triggers:
    'click #start-snapshot-btn' : 'start'
