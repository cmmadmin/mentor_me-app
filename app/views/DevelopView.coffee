###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
MM = require( 'Application' )
View = require('./supers/View')
Snapshot = require('./templates/Snapshot')
Develop = require('./templates/Develop')
LifeList = require('./templates/LifeList')
Mentee = require('models/Mentee')

module.exports = class DevelopView extends View
  #template: template

  initialize: ->
    super
    @collection = switch @options.type
      when "snapshot"
        @template = Snapshot
        MM.collections.snapshotQuestions
      when "develop"
        @template = Develop
        MM.collections.developQuestions
      when "lifelist"
        @template = LifeList
        MM.collections.lifelistQuestions

    @listenTo @collection, 'reset', @render
    @listenTo @collection, 'add remove change', _.debounce(@render)
    @listenTo @collection, 'fetch', @showLoading

  render: ->
    super
    return @

  getRenderData: ->
    mentee: @model
    questions: @collection.toJSON()

  showLoading: ->
    @$el.html("<img src='images/spinner.gif'>")
