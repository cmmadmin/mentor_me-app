@MM.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  Mentee = App.Models.Mentee
  Mentees = App.Collections.Mentees
  MenteeView = App.Views.MenteeView
  EditMenteeView = App.Views.EditMenteeView
  JournalView = App.Views.JournalView
  JournalEntries = App.Collections.JournalEntries
  SnapshotController = App.Controllers.SnapshotController

  class AppController extends Marionette.Controller

    home: ->
      Backbone.history.navigate('mentees', trigger: true, replace: true)

    login: ->
      return if MM.loginOpen
      MM.loginOpen = true
      $('#tbModal').append(MM.loginPanel.$el)
      MM.loginPanel.render().delegateEvents()
      $('#tbModal').modal('show')