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
    contact_home:
      title: "Contact Home"
      content: """
               This is the main home page for your contact. Here you have access to all the mentoring tools. Step through each of the tools in order to begin mentoring your student.

               1. Start with Snapshot to get an idea of what areas of development you should work on with the student
               2. Use the Develop tool to create a Plan to address certain areas of development
               """
    snapshot: 
      title: "Snapshot"
      content: "It's for taking a snapshot of the user duh"
