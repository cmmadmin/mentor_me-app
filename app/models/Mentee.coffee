Model = require('./supers/Model')
Collection = require('./supers/Collection')

module.exports = class Mentee extends Model
  urlRoot: Collection.serverUrl('mentees')

  age: ->
    birth_date = @get('birth_date')
    if birth_date
      ageMS = (new Date()) - new Date(birth_date)
      age = new Date()
      age.setTime(ageMS);
      ageYear = age.getFullYear() - 1970; 
    else
      "Unknown"