###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM.module "Views.Snapshot", (Snapshot, App, Backbone, Marionette, $, _) ->

  class Snapshot.InteractiveQuizView extends Marionette.ItemView
    template: 'templates/snapshot/InteractiveQuiz'

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