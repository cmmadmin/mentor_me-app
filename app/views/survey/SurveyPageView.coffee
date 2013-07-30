MM = require( 'MentorMe' )
SinglePage = require('templates/survey/SinglePage')
GroupedPage = require('templates/survey/GroupedPage')

module.exports = class SurveyPageView extends Marionette.ItemView

  attributes:
    class: 'swiper-slide'

  getTemplate: ->
    (if @options.grouped then GroupedPage else SinglePage)

  initialize: (options) ->
    _.defaults options,
      grouped: false;

    super

  onShow: ->
    @deserializeForm()

  serializeData: ->
    result = super
    _.extend(result, questions: @model.questions().toJSON()) if @options.grouped
    return result

  serializeForm: ->
    Backbone.Syphon.serialize(@)

  deserializeForm: ->
    Backbone.Syphon.deserialize(@, @options.data)