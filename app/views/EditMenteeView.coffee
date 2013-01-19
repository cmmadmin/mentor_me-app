View = require('./supers/View')
template = require('./templates/EditMentee')

module.exports = class EditMenteeView extends View
  template: template
  render: ->
    super
    @$el.parent().trigger('create')