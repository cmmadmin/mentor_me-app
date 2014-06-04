@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->
  JournalEntry = App.Models.JournalEntry
  MenteeProfileView = Views.MenteeProfileView
  EditMenteeView = Views.EditMenteeView
  ProfileButtonView = Views.ProfileButtonView

  class Views.MenteeView extends Marionette.Layout
    template: 'templates/Mentee'

    attributes:
      'style' : 'height: 100%'

    events:
      'click #profile-pic': 'getPicture'
      'click .details': 'openHeader'

    regions:
      snapshotBtn: '#snapshotBtn'
      selfassessBtn: '#selfassessBtn'
      interviewBtn: '#interviewBtn'
      observationsBtn: '#observationsBtn'
      developBtn: '#developBtn'
      lifelistBtn: '#lifelistBtn'
      planBtn: '#planBtn'
      journalBtn: '#journalBtn'
      contactsBtn: '#contactsBtn'
      editMentee: '#edit-mentee'

    buttonViews: {}

    editing: false

    initialize: ->
      super
      @initButtonViews();

    initButtonViews: ->
      @buttonViews.snapshotBtn = new ProfileButtonView(title: "Snapshot", icon: 'camera-retro', href: "#mentees/#{@model.id}/selfassess", state: 'snapshot')
      @buttonViews.selfassessBtn = new ProfileButtonView(title: "Self Assessment", icon: 'camera-retro', href: "#mentees/#{@model.id}/selfassess", state: 'selfassess')
      @buttonViews.interviewBtn = new ProfileButtonView(title: "Interview", icon: 'camera-retro', href: "#mentees/#{@model.id}/interview", state: 'snapshot')
      @buttonViews.observationsBtn = new ProfileButtonView(title: "Long Term Observations", icon: 'camera-retro', href: "#mentees/#{@model.id}/observations", state: 'snapshot')

      @buttonViews.developBtn = new ProfileButtonView(title: "Develop", icon: 'comment', href: "#mentees/#{@model.id}/develop", state: 'develop')
      @buttonViews.lifelistBtn = new ProfileButtonView(title: "Life List", icon: 'list', href: "#mentees/#{@model.id}/lifelist", state: 'lifelist')
      @buttonViews.planBtn = new ProfileButtonView(title: "Plan", icon: 'list', href: "#mentees/#{@model.id}/develop", state: 'develop')

      @buttonViews.journalBtn = new ProfileButtonView(title: "Journal", icon: 'pencil', href: "#mentees/#{@model.id}/journal")
      @buttonViews.contactsBtn = new ProfileButtonView(title: "Contacts", icon: 'user', href: '#')

    onShow: ->
      # @listenTo @model, 'change', @render
      _.each(@regions, (region) =>
        if(region.slice(-3) == 'Btn')
          regionName = region.substr(1)
          @[regionName].show(@buttonViews[regionName])
      )
      rivets.bind(@$el, {mentee: @model})
      #view = new MenteeProfileView(model: @model)
      #@actionRegion.show(view)
      # rivets.bind(@$el, {mentee: @model})
      #
    openHeader: (e) ->
      $('.contact-head').addClass('overcome')
      $('.details').hide();
      editView = new EditMenteeView(model: @model)
      @editMentee.show(editView)
      editView.on 'close', =>
        @editMentee.close();
        @$el.find('.contact-head').removeClass('overcome')
        $('.details').show();


    getPicture: (e) =>
      navigator.camera.getPicture(@cameraSuccess, @cameraFail,
        destinationType: Camera.DestinationType.FILE_URI
      )

    cameraSuccess: (imageURI) ->
      console.log(imageURI);
      $('#profile-pic').src = imageURI;
      console.log(imageURI);
    cameraFail: (e) ->
      console.log(e);