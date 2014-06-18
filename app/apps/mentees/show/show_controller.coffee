@MM.module "MenteesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
          type: 'Info'
      ]

    initialize: (options) ->
      { mentee, id } = options
      mentee or= App.request "mentees:entity", id
      menus = App.request "menu:entities"

      @layout = @getLayoutView mentee

      @listenTo @layout, "show", =>
        @bannerRegion mentee
        @menuRegion menus

      @show @layout

    bannerRegion: (mentee) ->
      bannerView = @getTitleView mentee

      @listenTo bannerView, "edit:mentee:clicked", (args) ->
        App.vent.trigger "edit:mentee:clicked", args.model

      @show bannerView, region: @layout.bannerRegion

    menuRegion: (menus) ->
      showView = @getShowView menus

      scrollComp = App.request "ion:scroll:component", showView

      @show scrollComp, region: @layout.menuRegion
      #@show showView, region: @layout.menuRegion

    getTitleView: (mentee) ->
      new Show.Banner
        model: mentee

    getLayoutView: (mentee) ->
      new Show.Layout
        model: mentee

    getShowView: (menus) ->
      new Show.MenteeMenu
        collection: menus

