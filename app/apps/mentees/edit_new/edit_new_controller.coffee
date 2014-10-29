@MM.module "MenteesApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'edit_new_mentee'
      ]

    initialize: (options) ->
      { mentees, mentee, id } = options

      mentee ?= App.request "mentees:entity", id if id?
      mentee ?= App.Models.Mentee.create()
      @layout = @getLayoutView mentee
      @listenTo @layout, "form:submit", =>
        @formSubmit mentee, mentees
      @show @layout

    getLayoutView: (mentee) ->
      new EditNew.ItemView
        model: mentee

    formSubmit: (mentee, mentees) ->
      data = Backbone.Syphon.serialize @layout
      # Set Edition on profile created to current app's edition
      if mentee.isNew() then data.profile_edition_code = App.Config.ApplicationConfig.EDITION_CODE 
      mentee.save data, 
        wait: true
        collection: mentees
        success: ->
          App.navigate 'mentees', trigger: true