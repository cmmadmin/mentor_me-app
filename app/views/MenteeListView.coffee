###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->
  application = App.MentorMe
  #template = require('./templates/MenteeListTemplate')
  Mentee = App.Models/Mentee
  MenteeListItemView = Views.MenteeListItemView

  class Views.MenteeListView extends Marionette.CollectionView
    itemView: MenteeListItemView

    tagName: 'ul'
    attributes:
      'data-role': 'listview'
      'class': 'nav nav-list'
    initialize: ->
      super

      #@listenTo @collection, 'reset', @render
      # @listenTo @collection, 'add remove change', _.debounce(@render)
      # @listenTo @collection, 'fetch', @showLoading

    showLoading: ->
      @$el.html("<img src='images/spinner.gif'>")
