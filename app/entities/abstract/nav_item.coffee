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
    triggerMethod: Marionette.triggerMethod
    initialize: ->
      tapHandler = @get('tap')
      if(tapHandler)
        @tap = tapHandler
        @unset('tap')   
      onTapHandler = @get('onTap')
      if(onTapHandler)
        @onTap = onTapHandler
        @unset('onTap')
    tap: ->
      @triggerMethod('tap')

  class Entities.NavBackButton extends Entities.NavButton
    defaults:
      type: 'Back'
      className: 'button-icon icon ion-ios7-arrow-back'
    # TODO: Replace with proper history management and rewriting
    tap: ->
      super
      window.history.back();
      # Backbone.history.history.back()

  class Entities.NavInfoButton extends Entities.NavButton
    defaults: 
      type: 'Info'
      className: 'button-icon icon ion-ios7-information-outline'
      promptId: null
    tap: ->
      super
      if @get('promptId')?
        App.commands.execute "show:prompt", @get('promptId')
      $('#prompt-region').removeClass('hidden-visibility')

  class Entities.NavButtonsCollection extends App.Collections.Supers.Collection
    model: (attrs, options) ->
      switch attrs.type
        when "Back" then new Entities.NavBackButton attrs, options
        when "Info" then new Entities.NavInfoButton attrs, options
        else new Entities.NavButton attrs, options