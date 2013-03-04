Model = require('./supers/Model')
Collection = require('./supers/Collection')

module.exports = class Question extends Model
  urlRoot: Collection.serverUrl('questions')
