Collection = require('./supers/Collection')


module.exports = class MenteeProfiles extends Collection

  url: ->
    Collection.serverUrl('mentees') + '/' + @owner.id + '/mentee_profiles'

  model: (attrs, options) ->
    MenteeProfile = require('models/MenteeProfile')
    return MenteeProfile.create(attrs, options)