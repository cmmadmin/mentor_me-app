@MM.module "DevelopApp.LifeList", (LifeList, App, Backbone, Marionette, $, _) ->

  class LifeList.Controller extends App.Controllers.Application
    initialize: (options) ->
      { categories } = options
      # @categories = App.request "develop_category:entities"
      @collectionView = @getCollectionView(categories)
      scrollComp = App.request "ion:scroll:component", @collectionView

      # @listenTo @collectionView, 'childview:category:toggled', ->
      #   scrollComp.getMainView().resize()
      @show scrollComp, options
      # @show @collectionView

    getCollectionView: (categories) ->
      new LifeList.Categories
        collection: categories