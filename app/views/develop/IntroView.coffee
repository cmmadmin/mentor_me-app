MM = require( 'MentorMe' )
template = require('templates/develop/Intro')

module.exports = class IntroView extends Marionette.ItemView
  template: template

  triggers:
    'click #start-develop-btn' : 'develop:intro:start:clicked'
