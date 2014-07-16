@MM.module "JournalApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [
        type: 'Info'
        pageId: 'journal'
      ]

    initialize: (options) ->
      { mentee } = options
      # journal_entries = App.request "journal:entities", mentee

      journal_entries = mentee.journal_entries()
      journal_entries.fetch()

      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @mainRegion journal_entries, mentee

      @show @layout

    mainRegion: (journal_entries, mentee) ->
      journalView = @getJournalView journal_entries

      @listenTo journalView, "new:journalentry:clicked", (args) ->
        App.vent.trigger "new:journalentry:clicked", args.collection

      @listenTo journalView, "edit:journalentry:clicked", (args) ->
        App.vent.trigger "edit:journalentry:clicked", args.model

      scrollComp = App.request "ion:scroll:component", journalView
      @show scrollComp, region: @layout.mainRegion

    getLayoutView: ->
      new List.Layout

    getJournalView: (journal_entries) ->
      new List.Journal
        collection: journal_entries
