@MM.module "MenteesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'contact_home'
      ]

    initialize: (options) ->
      { mentee, id } = options
      mentee or= App.request "mentees:entity", id
      menus = App.request "menu:entities"

      @layout = @getLayoutView mentee

      @listenTo @layout, "show", =>
        @bannerRegion mentee
        @menuRegion menus, mentee

      @show @layout

    bannerRegion: (mentee) ->
      bannerView = @getTitleView mentee

      @listenTo bannerView, "edit:mentee:clicked", (args) ->
        App.vent.trigger "edit:mentee:clicked", args.model

      @listenTo bannerView, "delete:mentee:clicked", (args) ->
        { model } = args
        if confirm "Are you sure you want to delete: #{model.get("name")}" then model.destroy
            success: ->
              Backbone.history.navigate('mentees', trigger: true)
        else 
          false

      @show bannerView, region: @layout.bannerRegion

    menuRegion: (menus, mentee) ->
      showView = @getShowView menus, mentee

      @listenTo showView, "snapshot:assess:clicked", (args) ->
        App.vent.trigger "snapshot:assess:clicked", mentee

      @listenTo showView, "snapshot:explore:clicked", (args) ->
        App.vent.trigger "snapshot:explore:clicked", mentee

      @listenTo showView, "snapshot:observe:clicked", (args) ->
        App.vent.trigger "snapshot:observe:clicked", mentee

      @listenTo showView, "develop:clicked", (args) ->
        App.vent.trigger "develop:clicked", mentee

      @listenTo showView, "journal:clicked", (args) ->
        App.vent.trigger "journal:clicked", mentee

      scrollComp = App.request "ion:scroll:component", showView
      @show scrollComp, region: @layout.menuRegion

    getTitleView: (mentee) ->
      new Show.Banner
        model: mentee

    getLayoutView: (mentee) ->
      new Show.Layout
        model: mentee

    getShowView: (menus, mentee) ->
      new Show.MenteeMenu
        collection: menus
        mentee: mentee