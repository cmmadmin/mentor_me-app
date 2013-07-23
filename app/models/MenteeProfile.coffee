Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class MenteeProfile extends Model

  urlRoot: ->
    Collection.serverUrl('mentees')() + '/' + @get('mentee_id') + '/journal_entries'

  
Mentee = require('models/Mentee')
Answers = require('collections/Answers')
# relationships defined afterwards
MenteeProfile.has().one('mentee', 
  model: Mentee
  inverse: 'active_profile'
)
MenteeProfile.has().many('answers', 
  collection: Answers
  inverse: 'mentee_profile'
)

