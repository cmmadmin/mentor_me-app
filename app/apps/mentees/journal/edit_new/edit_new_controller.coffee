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
      { journalEntries, id } = options

      journalEntry = App.request "journal:entity", id if id?
      journalEntry ?= new App.Entities.JournalEntry

      @layout = @getLayoutView(journalEntry)
      @listenTo @layout, "form:submit", =>
        if journalEntries
          @formSubmit journalEntries, journalEntry 
        else 
          @formSubmit false, journalEntry
      @show @layout

    getLayoutView: (journalEntry) ->
      new EditNew.ItemView
        model: journalEntry

    formSubmit: (journalEntries, journalEntry) ->
      data = Backbone.Syphon.serialize @layout
      if journalEntries
        journalEntry = App.Entities.JournalEntry.create(data)
        journalEntry.set('mentee_id', journalEntries.owner.id)
      else
        journalEntry.set('body': data.body, 'mentee_id': journalEntry.get('mentee_id'))
      journalEntry.save()
      Backbone.history.navigate('mentees/' + journalEntry.get('mentee_id') + '/journal', trigger: true)