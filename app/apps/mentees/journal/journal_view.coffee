@MM.module "MenteesApp.Journal", (Journal, App, Backbone, Marionette, $, _) ->

  class Journal.Layout extends App.Views.Layout
    template: "mentees/journal/journal_layout"

    regions:
      bannerRegion:  "#banner-region"
      mainRegion:   "#main-region"

  class Journal.Banner extends App.Views.ItemView
    template: "mentees/journal/journal_banner"

    modelEvents:
      "updated" : "render"

  class Journal.JournalItemView extends App.Views.ItemView
    template: "mentees/journal/journal_item"
    tagName: 'li'
    attributes:
      class: 'arrow'
    initialize: ->
      super
  #rivets.bind(@$el, {status: @model})
  #@$el.attr 'data-each-mentee-list', 'test'

  class Journal.JournalView extends App.Views.CompositeView
    template: "mentees/journal/journal"
    itemView: Journal.JournalItemView
    itemViewContainer: ".items"

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

      je = App.Models.JournalEntry.create(mentee_id: @collection.owner.id, body: content, logged_at: datetime)
      je.save().done ->
        $('#add-journal-textarea').val('').parent().removeClass 'selected'

    goBack: ->
      doIt = true;
      if $('#add-journal-textarea').val()
        doIt = confirm('Are you sure? You will lose what you have written in the journal box')
      if (doIt)
        Backbone.history.navigate('mentees/' + @collection.owner.id, trigger: true)