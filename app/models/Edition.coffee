Model = require('./supers/Model')
Collection = require('collections/supers/Collection')

module.exports = class Edition extends Model
  urlRoot: Collection.serverUrl('editions')

# Put at bottom to avoid circular dependency (ugly commonjs exports hack)
MenteeProfiles = require('collections/MenteeProfiles')
Surveys = require('collections/Surveys')

# Supermodel definitions
Edition.has().many('mentee_profiles', 
  collection: MenteeProfiles
  inverse: 'edition'
)

Edition.has().many('surveys', 
  collection: Surveys
  inverse: 'edition'
)