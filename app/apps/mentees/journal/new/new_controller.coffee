@MM.module "JournalApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
      ]

    initialize: (options) ->
      {journalEntries, journalEntry } = options

      journalEntry ?= new App.Entities.JournalEntry
      @layout = @getLayoutView(journalEntry)
      @listenTo @layout, "form:submit", =>
        @formSubmit journalEntries, journalEntry
      @show @layout

    getLayoutView: (journalEntry) ->
      new New.ItemView
        model: journalEntry

    formSubmit: (journalEntries, journalEntry) ->
      data = Backbone.Syphon.serialize @layout
      journalEntry = App.Entities.JournalEntry.create(data)
      journalEntry.set('mentee_id', journalEntries.owner.id)
      journalEntry.save()
      Backbone.history.navigate('mentees/' + journalEntries.owner.id + '/journal', trigger: true)