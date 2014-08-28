@MM.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  _.extend App,

    navigate: (route, options = {}) ->
      if !Backbone.History.started
        @firstRoute = [route, options]
      else
        Backbone.history.navigate route, options

    getCurrentRoute: ->
      frag = Backbone.history.fragment
      if _.isEmpty(frag) then null else frag

    startHistory: (options) ->
      if Backbone.history and !Backbone.History.started
        Backbone.history.start(options)
        if @firstRoute
          Backbone.history.navigate(@firstRoute...)