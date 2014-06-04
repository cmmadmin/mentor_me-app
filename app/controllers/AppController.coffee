@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.AppController extends Marionette.Controller

    home: ->
      Backbone.history.navigate('mentees', trigger: true, replace: true)

    login: ->
      return if MM.loginOpen
      MM.loginOpen = true
      $('#tbModal').append(MM.loginPanel.$el)
      MM.loginPanel.render().delegateEvents()
      $('#tbModal').modal('show')