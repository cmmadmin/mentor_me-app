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
MenteeProfiles = require('collections/MenteeProfiles')

# Supermodel definitions
Mentee.has().many('mentee_profiles', 
  collection: MenteeProfiles
  inverse: 'mentee'
)