@MM.module "DevelopApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "develop/show/develop_layout"
    className: 'full-page'

    regions:
      lifeListRegion: "#lifelist-region"
      stepsRegion: "#steps-region"
      planRegion: "#plan-region"

    onShow: ->
      @swiper = new Swiper('#develop-swiper',
        mode:'horizontal'
        pagination: '.pagination-sd'
      # preventClassNoSwiping: true
        noSwiping: true
        autoResize: true
        releaseFormElements: false
        onSlideChangeEnd: @onSlideChange
      )

    onClose: ->
      @swiper.destroy(true)

    onSlideChange: =>
      @trigger "slidechanged", Show.Slides[@swiper.activeIndex]