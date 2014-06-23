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

    triggers:
      "click #edit-button"   : "edit:mentee:clicked"
      "click #delete-button" : "delete:mentee:clicked"

  # Menu
  class Show.MenuItem extends App.Views.ItemView
    template: "mentees/show/show_menuitem"

  class Show.MenuCategory extends App.Views.CompositeView
    template: "mentees/show/show_menucategory"
    className: "accordion-group"
    itemView: Show.MenuItem
    itemViewContainer: ".accordion-inner"
    events:
      "click .accordion-heading" : "toggleChoose"

    @include "Chooseable"

    #logInfoUrl: ->
    #  console.log("hello")
#      @model.choose()
    #console.log(this.model.get('info_url'))
    #@$el.addClass('active')

    initialize: ->
      @collection = @model.items
      #@collection = @model.get('items');

  class Show.MenteeMenu extends App.Views.CompositeView
    template: "mentees/show/show_menteemenu"
    itemView: Show.MenuCategory
    itemViewContainer: ".accordion"
    id: "menu-inner"

    triggers:
      'click #Assess' : 'snapshot:assess:clicked'
      'click #Explore' : 'snapshot:explore:clicked'
      'click #Observe' : 'snapshot:observe:clicked'
      'click #Journal' : 'journal:clicked'
