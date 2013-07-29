MM = require( 'MentorMe' )
SinglePage = require('templates/survey/SinglePage')
GroupedPage = require('templates/survey/GroupedPage')

module.exports = class SurveyPageView extends Marionette.ItemView

  attributes:
    class: 'swiper-slide'

  getTemplate: ->
    (if @options.grouped then GroupedPage else SinglePage)

  events:
    'click #complete-assess-btn' : 'complete'

  initialize: (options) ->
    _.defaults options,
      grouped: false;

    super

  serializeData: ->
    result = super
    _.extend(result, questions: @model.questions().toJSON()) if @options.grouped
    return result

  complete: ->
    # TODO: save assessment here
    @trigger 'complete'