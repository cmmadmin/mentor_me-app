JournalItem = require('templates/partials/JournalItem')

module.exports = class JournalItemView extends Marionette.ItemView
  tagName: 'li'
  attributes:
    class: 'arrow'
  template: JournalItem
  initialize: ->
    super
    #rivets.bind(@$el, {status: @model})
    #@$el.attr 'data-each-mentee-list', 'test'