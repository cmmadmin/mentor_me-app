MM = require 'Application'
View = require('./supers/View')
template = require('./templates/Mentee')

JournalEntry = require('models/JournalEntry')

module.exports = class MenteeView extends View
  template: template

  events:
    'click #add-journal-btn' : 'addJournalEntry'
    'focus #add-journal-textarea' : 'focusAddJournal'
    'blur #add-journal-textarea' : 'unfocusAddJournal'

  initialize: ->
    @listenTo @model, 'change', @render

  render: ->
    super

  
  getRenderData: ->
    @model.toJSON()

  addJournalEntry: ->
    content = $('#add-journal-textarea').val()

    je = new JournalEntry(mentee_id: @model.id, body: content)
    je.save().done ->
      $('#add-journal-textarea').val('').parent().removeClass 'selected'

  # Style helpers
  focusAddJournal: (e) ->
    $(e.target).parent().addClass 'selected'

  unfocusAddJournal: (e) ->
    $targ = $(e.target)
    if !$targ.val()
      $targ.parent().removeClass 'selected'