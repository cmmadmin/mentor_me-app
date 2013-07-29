MenteeListItem = require('templates/partials/MenteeListItem')

module.exports = class MenteeListItemView extends Marionette.ItemView
  tagName: 'li'
  template: MenteeListItem

  onShow: ->
    @listenTo @model, 'change', _.debounce(@render)