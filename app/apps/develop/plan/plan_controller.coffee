@MM.module "DevelopApp.Plan", (Plan, App, Backbone, Marionette, $, _) ->

  class Plan.Controller extends App.Controllers.Application
    initialize: (options) ->
      @layout = @getLayoutView()
      # scrollComp = App.request "ion:scroll:component", @collectionView
      # 
      items = App.request "develop_item:entities"
      @chosenItems = new App.Entities.ChosenDevelopItemsCollection null,
        parent: ->
          items

      # @listenTo @collectionView, 'childview:category:toggled', ->
      #   scrollComp.getMainView().resize()
      #   
      @listenTo @layout, "show", =>
        @itemsRegion()
        @customItemRegion()

      @show @layout, options
      # @show @collectionView
      # 
      
    itemsRegion: ->
      itemsView = @getItemsView()

      scrollComp = App.request "ion:scroll:component", itemsView
      @show scrollComp, region: @layout.itemsRegion

    customItemRegion: ->

    getLayoutView: ->
      new Plan.Layout

    getItemsView: ->
      new Plan.Items
        collection: @chosenItems

    getCustomItemView: ->
      new Plan.CustomItem