@MM.module "UsersApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'edit_new_user'
      ]

    initialize: (options) ->
      { user } = options

      user ?= new App.Entities.User

      @layout = @getLayoutView user
      @listenTo @layout, "form:submit", =>
        @formSubmit user
      @show @layout

    getLayoutView: (user) ->
      new EditNew.ItemView
        model: user

    formSubmit: (user) ->
      data = Backbone.Syphon.serialize @layout
      user.save data,
        wait: true
        success: ->
          App.commands.execute "user:login", user