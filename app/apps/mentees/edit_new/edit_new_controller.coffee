@MM.module "MenteesApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
      ]

    initialize: (options) ->
      { mentees, mentee, id } = options

      mentee ?= App.request "mentees:entity", id if id?
      mentee ?= new App.Models.Mentee
      @layout = @getLayoutView(mentee)
      @listenTo @layout, "form:submit", @formSubmit mentee
      @show @layout

    createListeners: ->
      @listenTo @layout, "form:submit", @formSubmit mentee

    getLayoutView: (mentee) ->
      new EditNew.ItemView
        model: mentee

    formSubmit: (mentee) ->
      data = Backbone.Syphon.serialize @layout

      @model.save data

    getCollection: (options) ->
      options.collection or @contentView.collection