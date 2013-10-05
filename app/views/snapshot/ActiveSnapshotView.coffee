MM = require( 'MentorMe' )
template = require('templates/snapshot/Active')

module.exports = class IntroView extends Marionette.ItemView
  template: template

  triggers:
    'click #self-assess-btn' : 'snapshot:selfassess:clicked'
    'click #explore-btn' : 'snapshot:explore:clicked'
    'click #observe-btn' : 'snapshot:observe:clicked'


