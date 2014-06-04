@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.JournalView extends Marionette.CompositeView
    Models = App.Models

    itemView: Views.JournalItemView
    itemViewContainer: ".items"
    template: 'templates/Journal'

    events:
      'click #add-journal-btn' : 'addJournalEntry'
      'click #go-back-btn' : 'goBack'


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
      datetime = $('#add-journal-datetime').val()

      je = Models.JournalEntry.create(mentee_id: @collection.owner.id, body: content, logged_at: datetime)
      je.save().done ->
        $('#add-journal-textarea').val('').parent().removeClass 'selected'

    goBack: ->
      doIt = true;
      if $('#add-journal-textarea').val()
        doIt = confirm('Are you sure? You will lose what you have written in the journal box')
      if (doIt)
        Backbone.history.navigate('mentees/' + @collection.owner.id, trigger: true)