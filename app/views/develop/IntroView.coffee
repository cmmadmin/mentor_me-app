@MM.module "Views.Develop", (Develop, App, Backbone, Marionette, $, _) ->

  class Develop.IntroView extends Marionette.ItemView
    template: 'templates/develop/Intro'

    triggers:
      'click #start-develop-btn' : 'develop:intro:start:clicked'
