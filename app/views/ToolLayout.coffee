template = require('templates/ToolLayout')

module.exports = class ToolLayout extends Marionette.Layout
  template: template
  regions:
    mainRegion: '#surveyMain'