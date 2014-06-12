@MM.module "MenteesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "mentees/show/show_layout"

    regions:
      bannerRegion:  "#banner-region"
      menuRegion:   "#menu-region"

  class Show.Banner extends App.Views.ItemView
    template: "mentees/show/show_banner"

    modelEvents:
      "updated" : "render"

  # Menu

  ###class Show.SnapshotMenu extends App.Views.CollectionView
    itemView: Show.MenuItem
    className: "list"###

  #VillainView
  class Show.MenuItem extends App.Views.ItemView
    template: "mentees/show/show_menuitem"
    className: "menuitem item item-dark item-icon-left"
    #tagName: "li"

  #HeroView
  class Show.MenuCategory extends App.Views.CompositeView
    template: "mentees/show/show_menucategory"
    className: "menucategory accordion-group item item-dark item-icon-left" # TODO: bootstrap class
    itemView: Show.MenuItem
    itemViewContainer: "ul"
    events:
      "click": "logInfoUrl"

    logInfoUrl: ->
      console.log("hello")
      @model.choose()
    #console.log(this.model.get('info_url'))
    #@$el.addClass('active')

    initialize: ->
      @collection = @model.items
      #@collection = @model.get('items');

  #AccordionView
  class Show.MenteeMenu extends App.Views.CollectionView
    template: "mentees/show/show_menteemenu"
    itemView: Show.MenuCategory
    className: "list accordion" # TODO: bootstrap class
