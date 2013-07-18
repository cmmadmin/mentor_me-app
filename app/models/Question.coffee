Model = require('./supers/Model')
Collection = require('collections/supers/Collection')

module.exports = class Question extends Model
  urlRoot: Collection.serverUrl('questions')
