@MM.module "DevelopApp.SuggestedSteps", (SuggestedSteps, App, Backbone, Marionette, $, _) ->

  class SuggestedSteps.Controller extends App.Controllers.Application
    initialize: (options) ->
      { categories } = options
      categories or= App.request "develop_category:entities"
      parentFunc = ->
        categories
      chosenCategories = new App.Entities.ChosenDevelopCategoriesCollection(null, parent: parentFunc)

      @collectionView = @getCollectionView(chosenCategories)

      scrollComp = App.request "ion:scroll:component", @collectionView

      # @listenTo @collectionView, 'childview:category:toggled', ->
      #   scrollComp.getMainView().resize()
      @show scrollComp, options
      # @show @collectionView

    getCollectionView: (categories) ->
      new SuggestedSteps.Categories
        collection: categories