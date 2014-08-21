@MM.module "MenteesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "mentees/show/show_layout"
    className: "with-banner padded-page"
      
    regions:
      bannerRegion:  "#banner-region"
      menuRegion:   "#menu-region"

  class Show.Banner extends App.Views.ItemView
    template: "mentees/show/show_banner"

    modelEvents:
      "updated" : "render"

    triggers:
      "click .edit-button-container"   : "edit:mentee:clicked"
      "click #delete-button" : "delete:mentee:clicked"

  # Menu
  class Show.MenuItem extends App.Views.ItemView
    template: "mentees/show/show_menuitem"

    initialize: (options) ->
      @mentee = options.mentee

    templateHelpers:
      progress: ->
        @mentee.active_profile().getSurveyProgress(@model.attributes.surveyKey)

      isMax: ->
        if @mentee.active_profile().getSurveyProgress(@model.attributes.surveyKey) == 100 then true else false 

  class Show.MenuCategory extends App.Views.CompositeView
    template: "mentees/show/show_menucategory"
    className: "accordion-group"
    itemView: Show.MenuItem
    itemViewContainer: ".accordion-inner"
    itemViewOptions: ->
      mentee: @mentee

    events:
      "click .accordion-heading" : "toggleChoose"

    @include "Chooseable"

    #logInfoUrl: ->
    #  console.log("hello")
#      @model.choose()
    #console.log(this.model.get('info_url'))
    #@$el.addClass('active')

    initialize: (options) ->
      @collection = @model.items
      @mentee = options.mentee
      console.log @mentee
      #@collection = @model.get('items');

  class Show.MenteeMenu extends App.Views.CompositeView
    template: "mentees/show/show_menteemenu"
    
    initialize: (options) ->
      @mentee = options.mentee

    itemView: Show.MenuCategory
    itemViewContainer: ".accordion"
    itemViewOptions: ->
      mentee: @mentee

    id: "menu-inner"

    triggers:
      'click #Assess' : 'snapshot:assess:clicked'
      'click #Explore' : 'snapshot:explore:clicked'
      'click #Observe' : 'snapshot:observe:clicked'
      'click #menu-category-Develop' : 'develop:clicked'
      'click #Journal' : 'journal:clicked'
