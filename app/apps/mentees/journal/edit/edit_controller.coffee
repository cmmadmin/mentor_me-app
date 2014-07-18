@MM.module "JournalApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
      ]

    initialize: (options) ->
      { journalEntry } = options

      @layout = @getLayoutView(journalEntry)
      @listenTo @layout, "form:submit", =>
        @formSubmit journalEntry
      @show @layout

    getLayoutView: (journalEntry) ->
      new Edit.ItemView
        model: journalEntry

    formSubmit: (journalEntry) ->
      data = Backbone.Syphon.serialize @layout
      journalEntry.set('body': data.body, 'mentee_id': journalEntry.get('mentee_id'))
      journalEntry.save()
      Backbone.history.navigate('mentees/' + journalEntry.get('mentee_id') + '/journal', trigger: true)