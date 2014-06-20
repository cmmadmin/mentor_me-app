@MM.module "HeaderApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Header extends App.Views.Layout
    template: "header/show/header"
    regions:
      leftButtonsRegion: '#nav-left-buttons'
      rightButtonsRegion: '#nav-right-buttons'

  class Show.NavButton extends App.Views.ItemView
    template: "header/show/nav_button"
    tagName: "button"
    events: 
      'click': 'clicked'
    modelEvents:
      'change': 'render'
    className: ->
      "button" + (if @model.get('className') then " " + @model.get('className') else "")
    attributes: ->
      type: 'button'

    clicked: (e) ->
      @model.tap(e)

  class Show.NavButtons extends App.Views.CollectionView
    itemView: Show.NavButton
    className: "buttons"