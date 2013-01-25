View = require('./supers/View')

JournalItem = require('./templates/partials/JournalItem')

module.exports = class JournalItemView extends View
  tagName: 'li'
  attributes:
    class: 'arrow'
  template: JournalItem
  initialize: ->
    super
    #rivets.bind(@$el, {status: @model})
    #@$el.attr 'data-each-mentee-list', 'test'

  getRenderData: ->
    @model.toJSON()