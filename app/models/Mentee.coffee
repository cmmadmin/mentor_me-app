Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class Mentee extends Model
  urlRoot: Collection.serverUrl('mentees')

  initialize: ->
    super
    @memento = new Backbone.Memento(@);
    _.extend(@, @memento);

  age: ->
    birth_date = @get('birth_date')
    if birth_date
      ageMS = (new Date()) - new Date(birth_date)
      age = new Date()
      age.setTime(ageMS);
      ageYear = age.getFullYear() - 1970; 
    else
      "Unknown"

# Put at bottom to avoid circular dependency (ugly commonjs exports hack)
MenteeProfile = require('./MenteeProfile')
JournalEntries = require('collections/JournalEntries')

# Supermodel definitions
Mentee.has().one('active_profile', 
  model: MenteeProfile
  inverse: 'mentee'
)

Mentee.has().many('journal_entries', 
  collection: JournalEntries
  inverse: 'mentee'
)