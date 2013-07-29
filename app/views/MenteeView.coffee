MM = require 'MentorMe'
template = require('templates/Mentee')

JournalEntry = require('models/JournalEntry')
BackStackRegion = require('lib/ui/BackStackRegion')

MenteeProfileView = require('./MenteeProfileView')
EditMenteeView = require('./EditMenteeView')
ProfileButtonView = require('./ProfileButtonView')

module.exports = class MenteeView extends Marionette.Layout
  template: template

  attributes:
    'style' : 'height: 100%'

  events:
    'click #profile-pic': 'getPicture'
    'click .details': 'openHeader'

  regions:
    contactsBtn: '#contactsBtn'
    journalBtn: '#journalBtn'
    snapshotBtn: '#snapshotBtn'
    developBtn: '#developBtn'
    lifelistBtn: '#lifelistBtn'
    moreBtn: '#moreBtn'
    editMentee: '#edit-mentee'

  buttonViews: {}

  editing: false

  initialize: ->
    super
    @initButtonViews();

  initButtonViews: ->
    @buttonViews.contactsBtn = new ProfileButtonView(title: "Contacts", icon: 'user', href: '#')
    @buttonViews.journalBtn = new ProfileButtonView(title: "Journal", icon: 'pencil', href: '#journal')
    @buttonViews.snapshotBtn = new ProfileButtonView(title: "Snapshot", icon: 'camera-retro', href: "#mentees/#{@model.id}/snapshot", state: 'snapshot')
    @buttonViews.developBtn = new ProfileButtonView(title: "Develop", icon: 'comment', href: "#mentees/#{@model.id}/develop", state: 'develop')
    @buttonViews.lifelistBtn = new ProfileButtonView(title: "Life List", icon: 'list', href: "#mentees/#{@model.id}/lifelist", state: 'lifelist')
    @buttonViews.moreBtn = new ProfileButtonView(title: "More", icon: 'ellipsis-horizontal', href: '#more')
    
  onShow: ->
    # @listenTo @model, 'change', @render
    _.each(@regions, (region) =>
      if(region.slice(-3) == 'Btn')
        regionName = region.substr(1)
        @[regionName].show(@buttonViews[regionName])
    )
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