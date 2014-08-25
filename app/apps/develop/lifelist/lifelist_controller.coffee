@MM.module "DevelopApp.LifeList", (LifeList, App, Backbone, Marionette, $, _) ->

  class LifeList.Controller extends App.Controllers.Application
    initialize: (options) ->
      { categories } = options

      @layout = @getLayoutView()
      # @categories = App.request "develop_category:entities"
      # @collectionView = @getCollectionView categories

      # @listenTo @collectionView, 'childview:category:toggled', ->
      #   scrollComp.getMainView().resize()
      # @show @collectionView

      @listenTo @layout, "show", =>
        @accordionRegion categories

      @show @layout

      # @show @collectionView
      # scrollComp = App.request "ion:scroll:component", @collectionView
      # @show scrollComp, options

    accordionRegion: (categories) ->
      accordionView = @getAccordionView categories

      scrollComp = App.request "ion:scroll:component", accordionView
      @show accordionView, region: @layout.accordionRegion

    getAccordionView: (categories) ->
      new LifeList.Categories
        collection: categories

    getLayoutView: ->
      new LifeList.Layout