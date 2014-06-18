@MM.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  mixinKeywords = ["beforeIncluded", "afterIncluded"]

  include = (objs...) ->
    klass = @

    for obj in objs
      concern = App.request "concern", obj

      ## call the beforeIncluded method if it exists on our concern
      ## the context of 'this' within beforeIncluded method will be
      ## the prototype of our klass
      concern.beforeIncluded?.call(klass.prototype, klass, concern)

      ## mix the concern into our klasses prototype minus any
      ## methods or properties in 'mixinKeywords'
      Cocktail.mixin klass, _(concern).omit(mixinKeywords...)

      ## call the afterIncluded method if it exists on our concern
      concern.afterIncluded?.call(klass.prototype, klass, concern)

    ## return the klass for chaining purposes
    return klass

  ## the modules and klasses we are monkey patching
  modules = [
    { Marionette: ["ItemView", "Layout", "CollectionView", "CompositeView"] }
    { Entities:   ["Model", "Collection"] }
  ]

  for module in modules
    for key, klasses of module
      for klass in klasses
        obj = window[key] or App[key]
        obj[klass].include = include