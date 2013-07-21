Model = require('./supers/Model')
Collection = require('collections/supers/Collection')

module.exports = class Edition extends Model
  urlRoot: Collection.serverUrl('editions')