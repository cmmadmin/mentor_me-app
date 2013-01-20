View = require('./supers/View')
template = require('./templates/EditMentee')

module.exports = class EditMenteeView extends View
  template: template
  id: 'mentee'

  initialize: ->
    
  render: ->
    super
    @$el.parent().trigger('create')
    rivets.bind(@$el, {mentee: @model})