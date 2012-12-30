###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

View = require('./supers/View')
#template = require('./templates/MenteeListTemplate')

module.exports = class MenteeListView extends View
  tagName: 'ul'