###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM.module "Views.Snapshot", (Snapshot, App, Backbone, Marionette, $, _) ->

  class Snapshot.SelfAssessView extends Marionette.ItemView
    template: 'templates/snapshot/SelfAssess'

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