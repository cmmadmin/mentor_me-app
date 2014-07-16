@MM.module "JournalApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "mentees/journal/list/list_layout"

    regions:
      mainRegion: "#journal-region"

  class List.ItemView extends App.Views.ItemView
    template: "mentees/journal/list/list_item"
    tagName: 'li'
    attributes:
      class: 'arrow'
    initialize: ->
      super
  #rivets.bind(@$el, {status: @model})
  #@$el.attr 'data-each-mentee-list', 'test'

  class List.Empty extends App.Views.ItemView
    template: "mentees/journal/list/empty"
    tagName: "li"

  class List.Journal extends App.Views.CompositeView
    template: "mentees/journal/list/journal"
    itemView: List.ItemView
    emptyView: List.Empty
    itemViewContainer: ".items"

    triggers: 
      'click #new-entry' : 'new:journalentry:clicked'
      'click #edit-entry' : 'edit:journalentry:clicked'

    events:
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
    # newJournalEntry: (e) =>
      # content = $('#add-journal-textarea').val()
      # datetime = $('#add-journal-datetime').val()

      # je = App.Entities.JournalEntry.create(mentee_id: @collection.owner.id, body: content, logged_at: datetime)
      # je.save().done ->
      #   $('#add-journal-textarea').val('').parent().removeClass 'selected'

    goBack: ->
      doIt = true;
      if $('#add-journal-textarea').val()
        doIt = confirm('Are you sure? You will lose what you have written in the journal box')
      if (doIt)
        Backbone.history.navigate('mentees/' + @collection.owner.id, trigger: true)