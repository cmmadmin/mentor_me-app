@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.JournalItemView extends Marionette.ItemView
    tagName: 'li'
    attributes:
      class: 'arrow'
    template: 'templates/partials/JournalItem'
    initialize: ->
      super
      #rivets.bind(@$el, {status: @model})
      #@$el.attr 'data-each-mentee-list', 'test'