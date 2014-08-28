###
 * Application Bootstrapper
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM = do (Backbone, Marionette) ->

  MentorMe = new Marionette.Application

    currentUser: null

    loginOpen: false

    initEvents: ->
      # Check for not authenticated errors
      $(document).ajaxError (e, xhr, settings, exception) ->
        if (xhr.status == 401)
          MentorMe.vent.trigger "session:notauthenticated"

      @vent.bind "session:loaded", (sessionExists) =>
        if sessionExists
          @goHome()
        else
          @goRoot()

      @vent.bind "authentication:logged_out session:notauthenticated", =>
        MentorMe.navigate(MentorMe.rootRoute, true) unless @isCurrentRouteRoot()

      $(document).on "pause", =>
        @vent.trigger "app:pause"
      $(document).on "resume", =>
        @vent.trigger "app:resume"
  
    goHome: ->
      # MentorMe.startHistory()
      MentorMe.navigate("mentees", trigger: true)
    goRoot: ->
      MentorMe.navigate(MentorMe.rootRoute, true)
    # Are we at home or login page already?
    isCurrentRouteRoot: ->
      Backbone.history.fragment == "home" or Backbone.history.fragment == "login"

  MentorMe.rootRoute = "home"

  MentorMe.addRegions
    headerRegion: "#header-region"
    mainRegion:    "#content"
    footerRegion: "#pageFooter"
    promptRegion: "#prompt-region"

  MentorMe.on "initialize:before", (options) ->
    MentorMe.environment = options.environment

  MentorMe.addInitializer ->
    # Import views
    # HomePage = MentorMe.Views.HomePage
    
    # AppController = MentorMe.Controllers.AppController
    AppLayout = MentorMe.Views.AppLayout

    # #Import collections
    # Mentees = MentorMe.Collections.Mentees
    # Questions = MentorMe.Collections.Questions
    # Editions = MentorMe.Collections.Editions
    # Lifelists = MentorMe.Collections.Lifelists
    # LifelistCategories = MentorMe.Collections.LifelistCategories

    # # Initialize collections
    # @collections = 
    #   mentees: new Mentees()
    #   editions: new Editions()
    #   develop_categories: new MentorMe.Entities.DevelopCategoriesCollection()
    #   curriculums: new MentorMe.Entities.DevelopCurriculumsCollection()

    #   bootstrap: (update) ->
    #     MentorMe.vent.trigger('bootstrap:loaded')
    #     @mentees.reset(update.mentees)
    #     @editions.reset(update.editions)
    #     @develop_categories.reset(update.develop_categories)
    #     @curriculums.reset(update.develop_curriculums)

    # TODO: Use proper server bootstrap
    # Bootstrap initial data
    # @collections.mentees.fetch();
    # @collections.questions.fetch();
    

    # Initialize views
    # @loginPanel = new LoginPanel()

    @appLayout = new AppLayout(el: "#mentor_me_app")
    @initEvents()

  MentorMe.addInitializer ->
    MentorMe.module("HeaderApp").start()

  MentorMe.addInitializer ->
    # sync = $.ajax(
    #   url: MentorMe.Config.ApplicationConfig.SERVER_URL + 'users/data'
    #   context: @collections
    # )
    # sync.then(@collections.bootstrap, @collections)
    # # sync.then(@goHome, MentorMe)
    # @collections._fetch = sync
        
  MentorMe.reqres.setHandler "default:region", -> MentorMe.mainRegion
  MentorMe.reqres.setHandler "concern", (concern) -> MentorMe.Concerns[concern]

  MentorMe.on "initialize:after", ->
  #   # Start Backbone router after bootstrap
  #   MentorMe.execute "when:fetched", MentorMe.collections, =>
    @startHistory()

  MentorMe.vent.on "header:shown", ->
    _.defer ->
      MentorMe.mainRegion.$el.addClass('with-header')
  MentorMe.vent.on "header:hidden", ->
    _.defer ->
      MentorMe.mainRegion.$el.removeClass('with-header')

  MentorMe
