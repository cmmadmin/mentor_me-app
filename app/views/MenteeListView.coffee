###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
application = require( 'Application' )
View = require('./supers/View')
#template = require('./templates/MenteeListTemplate')
Mentee = require('models/Mentee')
MenteeListItemView = require('./MenteeListItemView')

module.exports = class MenteeListView extends View
  tagName: 'ul'
  attributes:
    'data-role': 'listview'
  initialize: ->
    super

    @listenTo @collection, 'reset', @render
    @listenTo @collection, 'fetch', @showLoading

  render: ->
    super
    @$el.empty()
    @collection.each (mentee) =>
      @$el.append(new MenteeListItemView(model: mentee).render().el)

    # Stupid jquery mobile events don't work well
    # Using listview call for now, until we figure out better solution
    #@$el.listview('refresh');
    @$el.parent().trigger('create');

    return @
  showLoading: ->
    @$el.html("<img src='images/spinner.gif'>")
