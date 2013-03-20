MM = require 'MentorMe'
template = require('templates/Mentee')

JournalEntry = require('models/JournalEntry')
BackStackRegion = require('lib/ui/BackStackRegion')

MenteeProfileView = require('./MenteeProfileView')
EditMenteeView = require('./EditMenteeView')

module.exports = class MenteeView extends Marionette.Layout
  template: template

  events:
    'click #edit-mentee-btn' : 'editMentee'
    'click #profile-pic': 'getPicture'

  ui:
    editBtn: '#edit-mentee-btn'

  regions:
    actionRegion: 
      selector: '#mentee-action'
      regionType: BackStackRegion

  editing: false
    
  onShow: ->
    view = new MenteeProfileView(model: @model)
    @actionRegion.show(view)
    rivets.bind(@$el, {mentee: @model})

  doneEditing: (e) =>
    @ui.editBtn.show();
    # Keep views
    @actionRegion.show(new MenteeProfileView(model: @model), new BackStack.SlideEffect(direction: 'right'))
    @editing = false

  editMentee: (e) =>
    # Freeze model
    @model.store()
    @ui.editBtn.hide();
    editView = new EditMenteeView(model: @model)
    editView.on 'mentee:doneEditing', @doneEditing
    @actionRegion.pushView(editView)
    @editing = true

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