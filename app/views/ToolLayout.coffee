template = require('templates/ToolLayout')

module.exports = class ToolLayout extends Marionette.Layout
  template: template
  attributes:
    class: 'fullpage'
  regions:
    mainRegion: '#surveyMain'