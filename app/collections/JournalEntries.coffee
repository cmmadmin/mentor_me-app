@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection
  JournalEntry = App.Models.JournalEntry

  class Collections.JournalEntries extends Collection

    url: ->
      Collection.serverUrl('mentees') + '/' + @owner.id + '/journal_entries'

    initialize: (attrs) ->
      #@storage = new Offline.Storage('mentees', this)
      # @mentee_id = attrs.mentee_id
      super

    model: (attrs, options) ->
      return JournalEntry.create(attrs, options)