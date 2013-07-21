Collection = require('./Collection')

module.exports = class SuperCollection extends Collection

  model: (attrs, options) ->
    return @class.create(attrs, options)
      