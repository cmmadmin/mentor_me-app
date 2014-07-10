@MM.module "Config", (Config, App, Backbone, Marionette, $, _) ->

  Config.Prompts =
    contact_home: 
      title: "Main Home Page"
      content: """
               The Main Home page is a place where you can:
                 - Create a new Contact
                 - Get tired and exit the app
                 - Ponder on its beauty
               """
    contact_list:
      title: "Contact List"
      content: """
               The Contact List displays a list of the contacts.
               """
    snapshot: 
      title: "Snapshot"
      content: "It's for taking a snapshot of the user duh"
