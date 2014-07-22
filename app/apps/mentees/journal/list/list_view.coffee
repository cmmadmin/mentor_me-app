@MM.module "JournalApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "mentees/journal/list/list_layout"

    id: 'journal-list'

    regions:
      mainRegion: "#journal-region"

  class List.Empty extends App.Views.ItemView
    template: "mentees/journal/list/empty"
    tagName: "a"
    className: "item"

  class List.ItemView extends App.Views.ItemView
    template: "mentees/journal/list/list_item"
    tagName: 'a'
    className: "item item-dark"
    attributes: ->
      href: "#mentees/" + @model.get('mentee_id') + "/journal/" + @model.id
      
    triggers: 
      "click #delete-entry" : "delete:journalentry:clicked"
      "click #edit-entry" : "edit:journalentry:clicked"

  class List.Journal extends App.Views.CompositeView
    template: "mentees/journal/list/journal"
    itemView: List.ItemView
    itemViewContainer: "#entry-container"
    emptyView: List.Empty
    className: 'list'

    triggers: 
      'click #new-entry' : 'new:journalentry:clicked'

    events:
      'click #go-back-btn' : 'goBack'

    # attributes:
    #   'data-role': 'listview'
    #   'class': 'nav nav-list journal'

    goBack: ->
      doIt = true;
      if $('#add-journal-textarea').val()
        doIt = confirm('Are you sure? You will lose what you have written in the journal box')
      if (doIt)
        Backbone.history.navigate('mentees/' + @collection.owner.id, trigger: true)