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

  class Show.MenuCategory extends App.Views.ItemView
    template: "mentees/show/show_menucategory"
    className: "menucategory item item-dark item-icon-left"

  class Show.MenteeMenu extends App.Views.CompositeView
    template: "mentees/show/show_menteemenu"
    itemView: Show.MenuCategory
    className: "list"

  class Show.MenuItem extends App.Views.ItemView
    template: "mentees/show/show_menuitem"
    className: "menucategory item item-dark item-icon-left"

  class Show.SnapshotMenu extends App.Views.CollectionView
    itemView: Show.MenuItem
    className: "list"