@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class ToolLayout extends Marionette.Layout
    template: 'templates/ToolLayout'
    attributes:
      class: 'fullpage'
    regions:
      mainRegion: '#surveyMain'