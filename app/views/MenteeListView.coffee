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
  initialize: ->
    super

    @collection.on 'reset', @render, @
    @collection.on 'fetch', @showLoading, @

    @$el.attr 'data-role', 'listview'

  render: ->
    super
    @$el.empty()
    @collection.each (mentee) =>
      @$el.append(new MenteeListItemView(model: mentee).render().el)

    return @

  showLoading: ->
    @$el.html("<img src='images/spinner.gif'>")
