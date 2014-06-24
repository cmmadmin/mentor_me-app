@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.SurveyPageView extends App.Views.ItemView
    SinglePage = 'templates/survey/SinglePage'
    GroupedPage = 'templates/survey/GroupedPage'

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