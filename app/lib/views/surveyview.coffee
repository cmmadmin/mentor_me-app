@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  QUESTIONS_PER_PAGE = 4

  class Views.ToolLayout extends Marionette.Layout
    template: 'templates/ToolLayout'
    attributes:
      class: 'fullpage'
    regions:
      mainRegion: '#surveyMain'

  class Views.SurveyView extends Marionette.CompositeView
    template: 'templates/survey/Survey'

    itemView: Views.SurveyPageView
    itemViewContainer: ".swiper-wrapper"

    attributes:
      class: 'fullpage'

    events:
      'click .save-n-close-btn' : 'complete'

    ui:
      surveySwiper: '.survey-swiper'
      saveBtn: '.save-n-close-btn'

    initialize: (options) ->
      @options = _.defaults options,
        grouped: false
        showCompleteBtn: true
      @survey = options.survey

      @setupCollection()

      super

      @profile = MM.request('get:current:profile')

    onRender: ->
      # Add last page
      if @options.showLastSlide
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
                      </div>
                    </div>")

    onShow: ->
      console.log("SurveyView:onShow")
      @swiper = new Swiper('.survey-swiper',
        mode:'horizontal'
        pagination: '.pagination-sd'
      # preventClassNoSwiping: true
        noSwiping: true
        autoResize: true
        releaseFormElements: true
        onSlideChangeEnd: @onSlideChange
      )

    onClose: ->
      console.log("SurveyView:onClose")
      @swiper.destroy(true)

    onSlideChange: (swiper) =>
      return unless @options.showCompleteBtn
      lastIdx = swiper.getLastSlide().index()
      if swiper.activeIndex == lastIdx
        @ui.saveBtn.text('Done').addClass('btn-success')
      else
        @ui.saveBtn.text('Save & Close').removeClass('btn-success')

    itemViewOptions: (model) ->
      profile = MM.request "get:current:profile"
      data = if @options.grouped then model.serializeAnswers(profile) else model.serializeAnswer(profile)
      _.extend @options,
        data: {questions: data}

    serializeData: ->
      @options

    complete: ->
      forms = @children.map (view) -> view.serializeForm().questions
      answers = _.reduce forms, (memo, form) ->
        _.extend(memo, form)

      profile = MM.request "get:current:profile"
      for question_id, answer of answers
        profile.saveAnswer question_id, answer

      if @options.showCompleteBtn && @swiper.activeIndex == @swiper.getLastSlide().index()
        @trigger 'complete'
      else
        @trigger 'savenclose'

    # TODO: Do proper setup in model or controller once refactored, instead of view
    setupCollection: ->
      if @options.grouped
        groups = @survey.question_groups()
        pages = new Backbone.Collection
        # Paginate groups by QUESTIONS_PER_PAGE
        groups.each (group) ->
          size = group.questions().size()
          pageCount = Math.ceil(size / QUESTIONS_PER_PAGE)
          for page in [0...pageCount]
            startIdx = page*QUESTIONS_PER_PAGE
            questions = new Backbone.Collection(group.questions()[startIdx...startIdx+QUESTIONS_PER_PAGE])
            # Create a new "QuestionPage" per page of questions within the same QuestionGroup
            newPage = new App.Entities.QuestionPage(questions: questions, title: group.get('title'))
            pages.add(newPage)
        @collection = pages
      else
        @collection = @survey.default_question_group().questions()