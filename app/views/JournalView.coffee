JournalEntry = require('models/JournalEntry')
JournalItemView = require('./JournalItemView')
template = require('templates/Journal')

module.exports = class JournalView extends Marionette.CompositeView
  itemView: JournalItemView
  itemViewContainer: ".items"
  template: template

  events:
    'click #add-journal-btn' : 'addJournalEntry'


  tagName: 'ul'
  attributes:
    'data-role': 'listview'
    'class': 'nav nav-list journal'
  initialize: ->
    super

    #@listenTo @collection, 'reset', @render
    #@listenTo @collection, 'add remove change', _.debounce(@render)
    #@listenTo @collection, 'fetch', @showLoading
    #
  addJournalEntry: ->
    content = $('#add-journal-textarea').val()

    je = JournalEntry.create(mentee_id: @collection.owner.id, body: content)
    je.save().done ->
      $('#add-journal-textarea').val('').parent().removeClass 'selected'