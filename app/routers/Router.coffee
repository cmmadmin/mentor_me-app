@MM.module "Routers", (Routers, App, Backbone, Marionette, $, _) ->
  class Routers.Router extends Marionette.AppRouter
      
    appRoutes:
          '' : 'home'
          'login': 'login'
