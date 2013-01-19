View = require('./supers/View')
template = require('./templates/Mentee')

module.exports = class MenteeView extends View
  template: template

  initialize: ->
    @listenTo @model, 'change', @render
  
  getRenderData: ->
    @model.toJSON()