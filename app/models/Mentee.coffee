Model = require('./supers/Model')
Collection = require('./supers/Collection')

module.exports = class Mentee extends Model
  urlRoot: Collection.serverUrl('mentees')