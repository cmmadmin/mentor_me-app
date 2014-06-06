@MM.module "MenteesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: 'mentees/list/list_layout'

    id: 'mentee-list'

    regions:
      menteesRegion: "#mentees-region"

  class List.Empty extends App.Views.ItemView
    template: "mentees/list/empty"
    tagName: "li"
    className: "item"

  class List.Mentee extends App.Views.ItemView
    template: "mentees/list/mentee"
    tagName: "li"
    className: "mentee item"

  class List.Mentees extends App.Views.CollectionView
    itemView: List.Mentee
    emptyView: List.Empty
    tagName: "ul"
    className: "list"
    # itemViewContainer: "ul"


