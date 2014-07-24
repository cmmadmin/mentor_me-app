@MM.module "HomeApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->

      @layout = @getLayoutView()
      
      @listenTo @layout, "register:button:clicked", ->
        App.vent.trigger "user:new:clicked"

      @listenTo @layout, "login:button:clicked", ->
        App.vent.trigger "user:login:clicked"

      @show @layout

    getLayoutView: ->
      new Show.Layout
