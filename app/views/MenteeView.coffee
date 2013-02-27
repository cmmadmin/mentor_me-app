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
    @$el.find('#journaldate').editable
      mode: 'inline'
      viewformat: 'M d'
    @$el.find('#journaldate').on 'shown', ->
      $(@).next().find('.editable-input input').mask('99/99/99 99:99', placeholder: ' ')
    @
  
  getRenderData: ->
    _.extend(@model.toJSON(), @templateHelpers());

  addJournalEntry: ->
    content = $('#add-journal-textarea').val()
    timestamp = new Date($('#journaldate').text());

    je = new JournalEntry(mentee_id: @model.id, body: content, created_at: timestamp)
    je.save().done ->
      $('#add-journal-textarea').val('').parent().removeClass 'selected'
      $('.journal-notifications').notify(
        message: { text: 'Journal Entry added' }
        closable: false
        fadeOut: { enabled: true, delay: 3000 }
      ).show();

  # Style helpers
  focusAddJournal: (e) ->
    $(e.target).parent().addClass 'selected'

  unfocusAddJournal: (e) ->
    $targ = $(e.target)
    if !$targ.val()
      $targ.parent().removeClass 'selected'

  templateHelpers: =>
    view: @