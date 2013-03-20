###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
application = require( 'MentorMe' )
#template = require('./templates/MenteeListTemplate')
Mentee = require('models/Mentee')
MenteeListItemView = require('./MenteeListItemView')

module.exports = class MenteeListView extends Marionette.CollectionView
  itemView: MenteeListItemView

  tagName: 'ul'
  attributes:
    'data-role': 'listview'
    'class': 'nav nav-list'
  initialize: ->
    super

    #@listenTo @collection, 'reset', @render
    #listenTo @collection, 'add remove change', _.debounce(@render)
    @listenTo @collection, 'fetch', @showLoading

  showLoading: ->
    @$el.html("<img src='images/spinner.gif'>")
