@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class MenteeListItemView extends Marionette.ItemView
    tagName: 'li'
    template: 'templates/partials/MenteeListItem'

    onShow: ->
      @listenTo @model, 'change', _.debounce(@render)