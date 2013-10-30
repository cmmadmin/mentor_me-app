Model = require('./supers/Model')
Collection = require('collections/supers/Collection')


module.exports = class LifelistPick extends Model
  urlRoot: ->
    Collection.serverUrl('mentee_profiles') + '/' + @get('mentee_profile_id') + '/lifelist_picks'

# Put at bottom to avoid circular dependency (ugly commonjs exports hack)
MenteeProfile = require('./MenteeProfile')
LifelistItem = require('./LifelistItem')

# Supermodel definitions
LifelistPick.has().one('mentee_profile', 
  model: MenteeProfile
  inverse: 'lifelist_picks'
)

LifelistPick.has().one('lifelist_item', 
  model: LifelistItem
)