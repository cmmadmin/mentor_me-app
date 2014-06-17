@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.ItemView extends Marionette.ItemView

    # For reference see: http://mikefowler.me/2014/02/20/template-helpers-handlebars-backbone-marionette/
    # A better solution would be to create native handlebars helpers, but this simple solution works for now
    # It basically evaluates any functions in template helpers and merges the results into serializeData
    mixinTemplateHelpers: ->
      self = @
      templateHelpers = Marionette.getOption(self, "templateHelpers")
      result = {}

      target = target || {}

      if _.isFunction(templateHelpers)
        templateHelpers = templateHelpers.call(self)

      # This _.each block is what we're adding
      _.each templateHelpers, (helper, index) ->
          if _.isFunction(helper))
            result[index] = helper.call(self)
          else
            result[index] = helper

      return _.extend(target, result)