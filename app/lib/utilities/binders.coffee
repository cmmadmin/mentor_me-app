@MM.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  rivets.binders.chosen =
    publishes: true
    bind: (el) ->
      model = @model
      @chosenCallback = =>
        valm = @observer.target
        value = rivets._.Util.getInputValue el
        if value then valm.choose() else valm.unchoose()

      rivets._.Util.bindEvent el, 'change', @chosenCallback
    unbind: (el) ->
      rivets._.Util.unbindEvent el, 'change', @chosenCallback
    routine: (el, value) ->
      el.checked = !!value