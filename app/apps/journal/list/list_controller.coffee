@MM.module "JournalApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [
        type: 'Info'
        promptId: 'journal'
      ]

    initialize: (options) ->
      { mentee } = options

      # If the mentee is actually an ID and not a model, then get the mentee from ID.
      # This has only happened when navigating back from editing a journal entry.
      if !(mentee instanceof Backbone.Model)
        mentee = App.request "mentees:entity", mentee

      journalEntries = App.request "journal:entities", mentee

      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @mainRegion journalEntries, mentee

      @show @layout

    mainRegion: (journalEntries) ->
      journalView = @getJournalView journalEntries

      @listenTo journalView, "new:journalentry:clicked", (args) ->
        { collection } = args
        App.vent.trigger "new:journalentry:clicked", collection

      @listenTo journalView, "childview:edit:journalentry:clicked", (args) ->
        { model } = args
        App.vent.trigger "edit:journalentry:clicked", model

      @listenTo journalView, "childview:delete:journalentry:clicked", (args) ->
        { model } = args
        if confirm "Are you sure you want to delete this journal entry?" then model.destroy() else false

      scrollComp = App.request "ion:scroll:component", journalView
      @show scrollComp, region: @layout.mainRegion

    getLayoutView: ->
      new List.Layout

    getJournalView: (journalEntries) ->
      new List.Journal
        collection: journalEntries
