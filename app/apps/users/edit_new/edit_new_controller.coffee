@MM.module "UsersApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'edit_new'
      ]

    initialize: ->
      @layout = @getLayoutView()
      @show @layout

    getLayoutView: ->
      new EditNew.ItemView