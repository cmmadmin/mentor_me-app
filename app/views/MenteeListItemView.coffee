View = require('./supers/View')

MenteeListItem = require('./templates/partials/MenteeListItem')

module.exports = class MenteeListItemView extends View
  tagName: 'li'
  attributes:
    class: 'arrow'
  template: MenteeListItem
  initialize: ->
    super
    #rivets.bind(@$el, {status: @model})
    #@$el.attr 'data-each-mentee-list', 'test'

  getRenderData: ->
    @model.toJSON()