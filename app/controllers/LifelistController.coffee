@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  Controller = Controllers.Supers.Controller
  ToolLayout = App.Views.ToolLayout
  EditView = App.Views.Lifelist.EditView
  LifelistItem = App.Models/LifelistItem
  LifelistItems = App.Collections/LifelistItems
  
  class LifelistController extends Controller
    initialize: (options) ->
      console.log 'LifelistModule:Controller:initialize'
      @region = options.region
      @model = options.model

      @state = MM.request "get:profile:state", "lifelist"

      @layout = @getLayoutView()

      @buildWorkflow()
      @listenTo @layout, "show", =>
        @startWorkflow(@state.state)

      @show @layout

    showUntapped: ->
      lifelist = @model.edition().lifelist()
      selectedItems = @model.lifelist_picks().getItems()
      view = new EditView(model: lifelist, profile: @model, collection: lifelist.lifelist_items(), selectedItems: selectedItems)
      @listenTo view, "lifelist:edit:confirm:clicked", ->
        @workflow.handle('complete')
        @model.save()
      @layout.mainRegion.show(view)
    showComplete: ->
      @showUntapped();
      # @layout.mainRegion.show(view)


    buildWorkflow: ->
      profile = MM.request "get:current:profile"
      @workflow = profile.state.lifelist
      @listenTo @workflow, 'transition', (transition) =>
        @['show' + $.camelCase('pre-' + transition.toState.split(':').join('-')).substr(3)]()

      # @listenTo @state, 'transition', (transition) => @workflow.transition transition

    startWorkflow: (state) ->
      @['show' + $.camelCase('pre-' + state.split(':').join('-')).substr(3)]()
      # @workflow.transition state
      #
    getLayoutView: ->
      new ToolLayout()

    isActive: ->
      @workflow.state == "active"

    onClose: ->
      delete @workflow
      delete @layout
      delete @state