@MM.module "MenteesApp.Journal", (Journal, App, Backbone, Marionette, $, _) ->

  class Journal.Controller extends App.Controllers.Application

    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [
        type: 'Info'
        promptId: 'journal'
      ]

    initialize: (options) ->
      { mentee, id } = options
      mentee or= App.request "mentees:entity", id

      journal_entries = mentee.journal_entries()
      journal_entries.fetch()

      @layout = @getLayoutView mentee

      @listenTo @layout, "show", =>
        @mainRegion journal_entries, mentee

      @show @layout

    mainRegion: (journal_entries, mentee) ->
      journalView = @getJournalView journal_entries

      scrollComp = App.request "ion:scroll:component", journalView
      @show scrollComp, region: @layout.mainRegion

    getLayoutView: (mentee) ->
      new Journal.Layout
        model: mentee

    getJournalView: (journal_entries) ->
      new Journal.JournalView
        collection: journal_entries

