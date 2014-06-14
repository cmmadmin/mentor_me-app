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
      ]

    initialize: ->
      mentees = App.request "mentees:entities"
      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @menteesRegion mentees

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

    addTapped: (e) ->
      alert 'You want to add a contact. Too bad, not implemented yet'

    signOutTapped: (e) ->
      alert "Nah, you don't want to do that"