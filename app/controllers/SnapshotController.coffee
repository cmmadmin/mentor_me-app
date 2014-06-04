@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  ToolLayout = App.View.ToolLayout
  Controller = Controllers.Supers.Controller

  class Controllers.SnapshotController extends Controller

    initialize: (options) ->
      console.log 'SnapshotModule:Controller:initialize'
      @region = options.region
      @model = options.model

      #@state = MM.request "get:profile:state", "snapshot"

      @layout = @getLayoutView()

      #@buildWorkflow()
      #
      #  @startWorkflow(@state.state)
      @listenTo @layout, "show", =>
        @showActive()
      @show @layout


    showActive: -> throw Error "unimplemented function: showActive"

    ###showUntapped: ->
      view = new IntroView(model: @model)
      @listenTo view, "snapshot:intro:start:clicked", ->
        @workflow.handle('start')

      @layout.mainRegion.show(view)###

    showComplete: ->
      @showActive()

    saveAndCloseSurvey: =>
      profile = MM.request "get:current:profile"
      profile.save()
      #if(@state.state == 'active' || @state.state == 'complete')
      #  @showActive()
      #else
      Backbone.history.navigate('mentees/' + @model.get('mentee_id'), trigger: true)

    completeSurvey: =>
      profile = MM.request "get:current:profile"
      #@workflow.handle('advance')
      profile.save()

    getLayoutView: ->
      new ToolLayout()

    ###buildWorkflow: ->
      profile = MM.request "get:current:profile"
      @workflow = new SnapshotViewFsm()
      @listenTo @workflow, 'transition', (transition) =>
        @['show' + $.camelCase('pre-' + transition.toState.split(':').join('-')).substr(3)]()

      # @listenTo @state, 'transition', (transition) => @workflow.transition transition

    startWorkflow: (state) ->
      @workflow.transition state

    isActive: ->
      @workflow.state == "active"###

    onClose: ->
  #    delete @workflow
      delete @layout
  #    delete @state
