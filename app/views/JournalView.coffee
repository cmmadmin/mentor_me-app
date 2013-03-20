JournalEntry = require('models/JournalEntry')
JournalItemView = require('./JournalItemView')

module.exports = class JournalView extends Marionette.CollectionView
  itemView: JournalItemView

  tagName: 'ul'
  attributes:
    'data-role': 'listview'
    'class': 'nav nav-list'
  initialize: ->
    super

    #@listenTo @collection, 'reset', @render
    #@listenTo @collection, 'add remove change', _.debounce(@render)
    #@listenTo @collection, 'fetch', @showLoading

  showLoading: ->
    @$el.html("<img src='images/spinner.gif'>")
