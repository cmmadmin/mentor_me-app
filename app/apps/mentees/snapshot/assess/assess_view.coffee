@MM.module "MenteesApp.Assess", (Assess, App, Backbone, Marionette, $, _) ->

  class Assess.SelfAssessView extends App.Views.ItemView
    template: "mentees/assess/assess"

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