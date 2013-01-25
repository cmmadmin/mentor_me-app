MM = require 'Application'
Model = require('./supers/Model')
Collection = require('./supers/Collection')

module.exports = class JournalEntry extends Model
  urlRoot: ->
    Collection.serverUrl('mentees')() + '/' + @get('mentee_id') + '/journal_entries'

  # TODO: Replace with backbone relational
  mentee: ->
    return MM.collections.getOrFetch(@get('mentee_id'))