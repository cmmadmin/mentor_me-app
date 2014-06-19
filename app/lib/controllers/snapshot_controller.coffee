@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.SnapshotController extends App.Controllers.Application

    initialize: (options) ->
      { mentee, id } = options
      mentee or= App.request "mentees:entity", id

      console.log 'SnapshotModule:Controller:initialize'

      @region = options.region

      @updateProfile mentee
      @model = App.request 'get:current:profile'

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
      new App.Views.ToolLayout()

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

    updateProfile: (mentee) ->
      if profile = mentee.active_profile()
        @profileController or= new Controllers.ProfileController(profile: profile)
        @profileController.setProfile(profile)
      else
        console.error("Data error: Mentee is missing an active profile")

    closeProfile: ->
      if @profileController
        @profileController.close();
        @profileController = null;