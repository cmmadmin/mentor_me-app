ToolFsm = require('./ToolFsm')

module.exports = LifeListFsm = ToolFsm.extend
  states:
    untapped:
      start: ->
        # do nothing