template = require('templates/partials/MenteeActions')
JournalEntry = require('models/JournalEntry')
module.exports = class MenteeDetailsView extends Marionette.ItemView

  template: template

  events:
    'click #add-journal-btn' : 'addJournalEntry'
    'focus #add-journal-textarea' : 'focusAddJournal'
    'blur #add-journal-textarea' : 'unfocusAddJournal'

  onRender: ->
    @$el.find('#journaldate').editable
      mode: 'inline'
      viewformat: 'M d'
    @$el.find('#journaldate').on 'shown', ->
      $(@).next().find('.editable-input input').mask('99/99/99 99:99', placeholder: ' ')

  onShow: ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'reset', @render

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