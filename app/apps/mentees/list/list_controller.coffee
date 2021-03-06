@MM.module "MenteesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        value: 'Sign Out'
        className: 'button-clear'
        tap: @signOutTapped
      ]
      rightButtons: [        
          className: 'button-icon icon ion-ios7-plus-empty light'
          tap: @addTapped
        ,
          type: 'Info'
          promptId: 'contact_list'
      ]

    initialize: ->
      @mentees = App.request "mentees:entities"
      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @menteesRegion @mentees

      @show @layout

    menteesRegion: (mentees) ->
      menteesView = @getMenteesView mentees

      # @listenTo menteesView, "childview:mentee:clicked", (child, args) ->
      #   App.vent.trigger "mentee:clicked"
      #   
      scrollComp = App.request "ion:scroll:component", menteesView
      @show scrollComp, region: @layout.menteesRegion

    getMenteesView: (mentees) ->
      new List.Mentees
        collection: mentees

    getLayoutView: ->
      new List.Layout

    addTapped: (e) =>
      App.vent.trigger "new:mentee:clicked", @mentees

    signOutTapped: (e) ->
      App.currentSession.logout()
      App.vent.trigger "user:notauthenticated"