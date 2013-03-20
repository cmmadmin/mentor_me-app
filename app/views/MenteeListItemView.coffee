MenteeListItem = require('templates/partials/MenteeListItem')

module.exports = class MenteeListItemView extends Marionette.ItemView
  tagName: 'li'
  template: MenteeListItem