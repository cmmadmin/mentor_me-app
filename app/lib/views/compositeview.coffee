@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.CompositeView extends Marionette.CompositeView
    itemViewEventPrefix: "childview"

    # appendHtml: (cv, itemView, index) ->
    #   return super if cv.isBuffering

    #   cc = if cv.itemViewContainer then cv.$(cv.itemViewContainer) else cv.$el
    #   children = cc.children()
    #   if children.size() <= index
    #     cc.append itemView.el
    #   else
    #     children.eq(index).before(itemView.el)