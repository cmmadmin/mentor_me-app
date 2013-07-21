Model = require('./supers/Model')
Collection = require('collections/supers/Collection')
Mentee = require('models/Mentee')

module.exports = class MenteeProfile extends Model

  urlRoot: ->
    Collection.serverUrl('mentees')() + '/' + @get('mentee_id') + '/journal_entries'

  
# relationships defined afterwards
MenteeProfile.has().one('mentee', 
  model: Mentee
  inverse: 'mentee_profiles'
)