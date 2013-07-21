SuperCollection = require('./supers/SuperCollection')
MenteeProfile = require('models/MenteeProfile')

module.exports = class MenteeProfiles extends SuperCollection

  model: MenteeProfile
  url: SuperCollection.serverUrl('mentee_profiles')