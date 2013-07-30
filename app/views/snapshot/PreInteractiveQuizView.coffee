###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
MM = require( 'MentorMe' )
template = require('templates/snapshot/PreInteractiveQuiz')

module.exports = class PreInteractiveQuizView extends Marionette.ItemView
  template: template

  triggers:
    'click #start-snapshot-btn' : 'snapshot:preinteractive:start:clicked'
