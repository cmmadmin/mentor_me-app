@MM.module "Collections", (Collections, App, Backbone, Marionette, $, _) ->
  Collection = Collections.Supers.Collection

  class Collections.MenteeProfiles extends Collection

    url: ->
      Collection.serverUrl('mentees') + '/' + @owner.id + '/mentee_profiles'

    model: (attrs, options) ->
      MenteeProfile = require('models/MenteeProfile')
      return MenteeProfile.create(attrs, options)