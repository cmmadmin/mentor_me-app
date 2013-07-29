MM = require( 'MentorMe' )
template = require('templates/survey/Survey')

SurveyPageView = require('./SurveyPageView')

module.exports = class SurveyView extends Marionette.CompositeView
  template: template

  itemView: SurveyPageView
  itemViewContainer: ".swiper-wrapper"

  attributes:
    class: 'fullpage'

  events:
    'click #complete-assess-btn' : 'complete'

  ui:
    surveySwiper: '.survey-swiper'

  initialize: (options) ->
    _.defaults options,
      grouped: false
    @survey = options.survey

    @setCollection()

    super

    @profile = MM.request('get:current:profile')
    
  onRender: ->
    # Add last page
    @ui.surveySwiper.find('.swiper-wrapper').append(
      "<div class='swiper-slide'>
        <div class='survey-page'>
          <p class='lead'>Comfortable with your answers?</p>
          <p>Ok, now you can either:<p>
          <p><ul>
            <li>Awkwardly and silently start browsing the internet on your mentor's phone</li>
            <li>Make a run for it (and get a free phone!)</li>
            <li>.... or hand it back to your mentor</li>
          </ul></p>
          <br/>
          <p>Ok, just hand it over...</p>
          <p><button class='btn btn-large btn-primary'>Done</button></p>
        </div>
      </div>")

  onShow: ->
    mySwiper = new Swiper('.survey-swiper', 
      mode:'horizontal'
      pagination: '.pagination-sd'
      moveStartThreshold:100
      # preventClassNoSwiping: true
      autoResize: true
      releaseFormElements: true
    )

  itemViewOptions: ->
    @options

  complete: ->
    # TODO: save assessment here
    @trigger 'complete'

  setCollection: ->
    @collection = (if @options.grouped then @survey.question_groups() else @survey.default_question_group().questions())