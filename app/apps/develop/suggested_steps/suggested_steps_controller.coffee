@MM.module "DevelopApp.SuggestedSteps", (SuggestedSteps, App, Backbone, Marionette, $, _) ->

  class SuggestedSteps.Controller extends App.Controllers.Application
    initialize: (options) ->
      { categories } = options
      categories or= App.request "develop_category:entities"
      parentFunc = ->
        categories
      chosenCategories = new App.Entities.ChosenDevelopCategoriesCollection(null, parent: parentFunc)

      @layout = @getLayoutView()
      # @collectionView = @getCollectionView(chosenCategories)

      # @listenTo @collectionView, 'childview:category:toggled', ->
      #   scrollComp.getMainView().resize()

      @listenTo @layout, "show", =>
        @accordionRegion chosenCategories

      @show @layout
      
      # @show @collectionView
      # scrollComp = App.request "ion:scroll:component", @collectionView
      # @show scrollComp, options

    accordionRegion: (categories) ->
      accordionView = @getAccordionView categories

      scrollComp = App.request "ion:scroll:component", accordionView
      @show accordionView, region: @layout.accordionRegion

    getAccordionView: (categories) ->
      new SuggestedSteps.Categories
        collection: categories

    getLayoutView: ->
      new SuggestedSteps.Layout