application = require( 'Application' )
View = require('./supers/View')
#template = require('./templates/MenteeListTemplate')
JournalEntry = require('models/JournalEntry')
JournalItemView = require('./JournalItemView')

module.exports = class JournalView extends View
  tagName: 'ul'
  attributes:
    'data-role': 'listview'
    'class': 'nav nav-list'
  initialize: ->
    super

    @listenTo @collection, 'reset', @render
    @listenTo @collection, 'add remove change', _.debounce(@render)
    @listenTo @collection, 'fetch', @showLoading

  render: ->
    super
    @$el.empty()
    @collection.each (journalEntry) =>
      @$el.append(new JournalItemView(model: journalEntry).render().el)

    # Stupid jquery mobile events don't work well
    # Using listview call for now, until we figure out better solution
    #@$el.listview('refresh');
    @$el.parent().trigger('create');

    return @
  showLoading: ->
    @$el.html("<img src='images/spinner.gif'>")
