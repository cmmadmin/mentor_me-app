###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
MM = require( 'MentorMe' )
template = require('templates/snapshot/PostInteractiveQuiz')

module.exports = class PostInteractiveQuizView extends Marionette.ItemView
  template: template

  triggers:
    'click #start-snapshot-btn' : 'snapshot:postinteractivequiz:confirm:clicked'
