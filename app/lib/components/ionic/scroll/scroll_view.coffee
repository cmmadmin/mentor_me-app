@MM.module "Components.Ionic.Scroll", (Scroll, App, Backbone, Marionette, $, _) ->

  class Scroll.ScrollLayout extends App.Views.Layout
    template: 'ionic/scroll/scroll'
    className: "scroll-content"

    regions:
      scrollContentRegion: '#scroll-content-region'

    initialize: (options = {}) ->
      { @config, @container } = options
      @config.el = @el

      # TODO: dd android platform detection for bouncing options
      # 

    onShow: ->
      _.defer =>
        @ionScrollView = new ionic.views.Scroll(@config);
        @_resize = _.bind(@ionScrollView.resize, @ionScrollView)
        @listenTo $(window), "resize", @_resize
        @ionScrollView.run()

    onClose: ->

    getScrollView: ->
      @ionScrollView

    getScrollPosition: ->
      @ionScrollView.getValues()

    resize: ->
      _.defer @_resize

    scrollTop: (shouldAnimate) ->
      @_resize() # Do we need to use a jquery style defferred before executing next action?
      @ionScrollView.scrollTo(0, 0, !!shouldAnimate)

    scrollBottom: (shouldAnimate) ->
      @_resize()
      max = @ionScrollView.getScrollMax()
      @ionScrollView.scrollTo(max.left, max.top, !!shouldAnimate)

    scrollTo: (left, top, shouldAnimate) ->
      @_resize()
      @ionScrollView.scrollTo(left, top, !!shouldAnimate)

    scrollBy: (left, top, shouldAnimate) ->
      @_resize()
      @ionScrollView.scrollBy(left, top, !!shouldAnimate)

    # TODO: Implement scroll position memory

    # TODO: Implement pull to refresh