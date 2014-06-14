@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.NavItem extends App.Models.Supers.Model
    initialize: ->
      leftButtons = this.get("leftButtons")
      if leftButtons
        this.set 'leftButtons', new Entities.NavButtonsCollection(leftButtons)
      rightButtons = this.get('rightButtons')
      if rightButtons
        this.set 'rightButtons', new Entities.NavButtonsCollection(rightButtons)

  class Entities.NavItemsCollection extends App.Collections.Supers.Collection
    model: Entities.NavItem

  class Entities.NavButton extends App.Models.Supers.Model
    initialize: ->
      tapHandler = @get('tap')
      if(tapHandler)
        @tap = tapHandler
        @unset('tap')   
    tap: ->
      # do nothing

  class Entities.NavBackButton extends Entities.NavButton
    defaults:
      type: 'Back'
      className: 'button-icon icon ion-ios7-arrow-back'
    # TODO: Replace with proper history management and rewriting
    tap: ->
      window.history.back();

  class Entities.NavInfoButton extends Entities.NavButton
    defaults: 
      type: 'Info'
      className: 'button-icon icon ion-ios7-information-outline'
    tap: ->
      # TODO: Trigger event to open prompt

  class Entities.NavButtonsCollection extends App.Collections.Supers.Collection
    model: (attrs, options) ->
      switch attrs.type
        when "Back" then new Entities.NavBackButton attrs, options
        when "Info" then new Entities.NavInfoButton attrs, options
        else new Entities.NavButton attrs, options