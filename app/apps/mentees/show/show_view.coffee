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

  class Show.MenteeMenu extends App.Views.CompositeView
    template: "mentees/show/show_menteemenu"
    itemView: Show.MenuCategory
    tagName: "div"
    className: "list"