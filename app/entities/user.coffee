@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.User extends Entities.Model
    urlRoot: Entities.Collection.serverUrl('users')

    toJSON: (args) ->
      {"user": super(args)}

  class Entities.UserCollection extends Entities.Collection

  Entities.on "before:start", ->
    Entities.User.has().many('mentees', 
      collection: App.Collections.Mentees
      inverse: 'mentor'
    )