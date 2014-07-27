@MM.module "Config", (Config, App, Backbone, Marionette, $, _) ->

  Config.Prompts =
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
    edit_new_mentee:
      title: "Edit/New Mentee"
      content: "Edit a contact or add a new contact"
    edit_new_user:
      title: "Edit/New User"
      content: "Edit a user or register a new user"
    snapshot: 
      title: "Snapshot"
      content: "Use this tool to get an idea of where your student is in their faithwalk"
    develop:
      title: "Develop"
      content: "Use this tool to decide which areas you could develop your student"
    journal:
      title: "Journal"
      content: "Take notes about your meetings and thoughts"
    login:
      title: "Login"
      content: "Login with your username and password"
