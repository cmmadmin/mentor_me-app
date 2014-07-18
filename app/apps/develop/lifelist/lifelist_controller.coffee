@MM.module "DevelopApp.LifeList", (LifeList, App, Backbone, Marionette, $, _) ->

  class LifeList.Controller extends App.Controllers.Application
    initialize: (options) ->
      @categories = App.request "develop_category:entities"
      @collectionView = @getCollectionView(@categories)
      scrollComp = App.request "ion:scroll:component", @collectionView
      @show scrollComp
      # @show @collectionView

    getCollectionView: (categories) ->
      new LifeList.Categories
        collection: categories