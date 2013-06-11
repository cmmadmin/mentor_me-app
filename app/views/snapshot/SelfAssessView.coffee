###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
MM = require( 'MentorMe' )
template = require('templates/snapshot/SelfAssess')

module.exports = class SelfAssessView extends Marionette.ItemView
  template: template

  events:
    'click #complete-assess-btn' : 'complete'

  onShow: ->
    mySwiper = new Swiper('.assess-swiper', 
      mode:'horizontal'
      pagination: '.pagination-sd'
      moveStartThreshold:100
      preventClassNoSwiping: true
    )

  complete: ->
    # TODO: save assessment here
    @trigger 'complete'