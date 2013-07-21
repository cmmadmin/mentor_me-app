Model = require('./supers/Model')
Collection = require('collections/supers/Collection')
Questions = require('collections/Questions')

module.exports = class Question extends Model
  urlRoot: Collection.serverUrl('questions')
  @collection: Questions