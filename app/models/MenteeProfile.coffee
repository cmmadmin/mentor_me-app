Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class MenteeProfile extends Model
  urlRoot: Collection.serverUrl('mentee_profiles')

  
Mentee = require('models/Mentee')
Edition = require('models/Edition')
Answers = require('collections/Answers')
# relationships defined afterwards
MenteeProfile.has().one('mentee', 
  model: Mentee
  inverse: 'active_profile'
)
MenteeProfile.has().one('edition', 
  model: Edition
  inverse: 'mentee_profiles'
)
MenteeProfile.has().many('answers', 
  collection: Answers
  inverse: 'mentee_profile'
)

