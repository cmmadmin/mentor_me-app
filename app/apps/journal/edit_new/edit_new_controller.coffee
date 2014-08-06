@MM.module "JournalApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'journal'
      ]

    initialize: (options) ->
      { journalEntries, journalEntry } = options

      # If journalEntries exists, that means it's new
      journalEntries ?= journalEntry.collection
      # If journalEntry exists, that means it's edit
      journalEntry ?= new App.Entities.JournalEntry

      @layout = @getLayoutView(journalEntry)
      @listenTo @layout, "journal:save", =>
        # if journalEntries
        @formSubmit journalEntries, journalEntry 
        # else 
        #   @formSubmit false, journalEntry
      @show @layout

    getLayoutView: (journalEntry) ->
      new EditNew.ItemView
        model: journalEntry

    formSubmit: (journalEntries, journalEntry) ->
      data = Backbone.Syphon.serialize @layout

      journalEntry ?= App.Entities.JournalEntry.create(data)
      journalEntry.set('body': data.body, 'mentee_id', journalEntries.owner.id)
   
      journalEntries.create(journalEntry)
      Backbone.history.navigate('mentees/' + journalEntries.owner.id + '/journal', trigger: true)