@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.User extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('users')

  class Entities.UserCollection extends Entities.Collection