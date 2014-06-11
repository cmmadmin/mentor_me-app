@MM.module "MenteesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application
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