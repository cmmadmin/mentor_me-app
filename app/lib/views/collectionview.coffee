@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.CollectionView extends Marionette.CollectionView
    itemViewEventPrefix: "childview"

    # Backbone Rails stuff (what does it do?)
    # appendHtml: (cv, itemView, index) ->
    #   return super if cv.isBuffering

    #   cc = if cv.itemViewContainer then cv.$(cv.itemViewContainer) else cv.$el
    #   children = cc.children()
    #   if children.size() <= index
    #     cc.append itemView.el
    #   else
    #     children.eq(index).before(itemView.el)