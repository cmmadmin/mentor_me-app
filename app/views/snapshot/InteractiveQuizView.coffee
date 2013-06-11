###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
MM = require( 'MentorMe' )
template = require('templates/snapshot/InteractiveQuiz')

module.exports = class InteractiveQuizView extends Marionette.ItemView
  template: template

  events:
    'click #complete-assess-btn' : 'complete'

  onShow: ->
    mySwiper = new Swiper('.quiz-swiper', 
      mode:'horizontal'
      pagination: '.pagination-sd'
      moveStartThreshold:100
      preventClassNoSwiping: true
    )

  complete: ->
    # TODO: save assessment here
    @trigger 'complete'