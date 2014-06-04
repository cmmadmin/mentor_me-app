@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  ToolLayout = App.Views.ToolLayout
  IntroView = App.Views.Develop.IntroView
  SurveyView = App.Views.SurveyView
  Controller = Controllers.Supers.Controller
  
  class Controllers.DevelopController extends Controller

    initialize: (options) ->
      console.log 'DevelopModule:Controller:initialize'
      @region = options.region
      @model = options.model

      @state = MM.request "get:profile:state", "develop"

      @layout = @getLayoutView()

      @buildWorkflow()
      @listenTo @layout, "show", =>
        @startWorkflow(@state.state)

      @show @layout
    

    showUntapped: ->
      view = new IntroView(model: @model)
      @listenTo view, "develop:intro:start:clicked", ->
        @workflow.handle('start')

      @layout.mainRegion.show(view)

    showActive: ->
      view = new SurveyView
        survey: @model.edition().developSurvey()
        title: "Develop"
        icon: "comment"
        showCompleteBtn: false
      @listenTo view, 'complete', @completeSurvey
      @listenTo view, 'savenclose', @saveAndCloseSurvey
      @layout.mainRegion.show(view)

    showComplete: ->
      @showActive()


    saveAndCloseSurvey: =>
      profile = MM.request "get:current:profile"
      profile.save()
      Backbone.history.navigate('mentees/' + @model.get('mentee_id'), trigger: true)

    completeSurvey: =>
      profile = MM.request "get:current:profile"
      @workflow.handle('advance')
      profile.save()

    getLayoutView: ->
      new ToolLayout()

    buildWorkflow: ->
      profile = MM.request "get:current:profile"
      @workflow = profile.state.develop
      @listenTo @workflow, 'transition', (transition) =>
        @['show' + $.camelCase('pre-' + transition.toState.split(':').join('-')).substr(3)]()
     
      # @listenTo @state, 'transition', (transition) => @workflow.transition transition
    
    startWorkflow: (state) ->
      @['show' + $.camelCase('pre-' + state.split(':').join('-')).substr(3)]()
      # @workflow.transition state

    isActive: ->
      @workflow.state == "active"

    onClose: ->
      delete @workflow
      delete @layout
      delete @state
