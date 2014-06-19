@MM.module "MenteesApp.Explore", (Explore, App, Backbone, Marionette, $, _) ->

  class Explore.ExploreView extends App.Views.ItemView
    template: 'templates/explore/explore'

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