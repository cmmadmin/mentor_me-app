@MM.module "Components.Ionic.Scroll", (Scroll, App, Backbone, Marionette, $, _) ->

  class Scroll.ScrollController extends App.Controllers.Application
    
    initialize: (options = {}) ->
      { @contentView, config } = options

      config = {} if !config?
      # _.defaults config, {}

      @scrollLayout = @getScrollLayout config
      @setMainView @scrollLayout

      @listenTo @scrollLayout, "show", @scrollContentRegion

    scrollContentRegion: ->
      @show @contentView, region: @scrollLayout.scrollContentRegion

    getScrollLayout: (config) ->
      new Scroll.ScrollLayout
        config: config

  App.reqres.setHandler "ion:scroll:component", (contentView, options = {}) ->
    throw new Error "Scroll Component requires a contentView to be passed in" if not contentView

    options.contentView = contentView
    new Scroll.ScrollController options