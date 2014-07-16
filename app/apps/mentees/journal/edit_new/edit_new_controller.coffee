@MM.module "JournalApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
      ]

    initialize: (options) ->
      { journalEntries, journalEntry } = options

      journalEntry ?= App.request "journal:entity", id if id?
      journalEntry ?= new App.Entities.JournalEntry
      @layout = @getLayoutView(journalEntry)
      @listenTo @layout, "form:submit", =>
        @formSubmit journalEntry, journalEntries
      @show @layout

    getLayoutView: (journalEntry) ->
      new EditNew.ItemView
        model: journalEntry

    formSubmit: (journalEntry, journalEntries) ->
      data = Backbone.Syphon.serialize @layout
      journalEntry.save data,
        wait: true
        collection: journalEntries
        success: ->
          Backbone.history.navigate('mentees', trigger: true)