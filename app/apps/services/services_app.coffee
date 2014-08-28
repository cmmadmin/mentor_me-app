@MM.module "ServicesApp", (Services, App, Backbone, Marionette, $, _) ->

  # API =
  #   log: ->
     
  _serviceInstances = []

  # App.vent.on "new:mentee:clicked", (mentees) ->
  #   App.navigate "mentees/new"
  #   API._new mentees
  #   API.observe mentee
    
  # App.addInitializer ->
  #   new MenteesApp.Router
  #     controller: API
  Services.addInitializer ->
    _serviceInstances.push new Services.Session

  Services.addFinalizer ->
    _.each _serviceInstances, (service) ->
      service.close()
    _serviceInstances = []