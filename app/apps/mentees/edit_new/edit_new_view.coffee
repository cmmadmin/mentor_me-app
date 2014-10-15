@MM.module "MenteesApp.EditNew", (EditNew, App, Backbone, Marionette, $, _) ->

  class EditNew.ItemView extends App.Views.ItemView
    template: "mentees/edit_new/edit_new_layout"

    tagName: "form"
    className: "padded-page"

    ui:
      avatarImg: '#edit-avatar-img'
      defaultUsrIcon: '.icon-user'

    events:
      "submit": 'preventSubmission'
      'click @ui.avatarImg': "editAvatar"
      'click @ui.defaultUsrIcon': "editAvatar"

    templateHelpers:
      pageTitle: ->
        (if @model.isNew() then "New" else "Edit") + " Contact"

    onRender: ->
      @binder = rivets.bind @$el, mentee: @model
      if @model.get 'avatar_mobile_url'
        @ui.avatarImg.toggleClass('hidden')
      else
        @ui.defaultUsrIcon.toggleClass('hidden')

    onClose: ->
      if @binder
        @binder.unbind()

    preventSubmission: (e) ->
      e.preventDefault()
      @trigger "form:submit"

    editAvatar: (e) ->
      if navigator.camera?
        sourceType = Camera.PictureSourceType.CAMERA
        navigator.notification.confirm(
          'Do you want to take a picture or select one from your photo library?',
          (buttonIndex) =>
            sourceType = if buttonIndex == 1 then Camera.PictureSourceType.CAMERA else Camera.PictureSourceType.PHOTOLIBRARY
            @getPicture sourceType
          'Change Profile Picture',
          ['Camera', 'Photo Library']
        )        

    getPicture: (sourceType) ->
      navigator.camera.getPicture(
        (imageURI) =>
          @upload(imageURI)
        (message) ->
          console.log "Failed because: #{message}"
        destinationType: Camera.DestinationType.FILE_URI
        sourceType: sourceType
        allowEdit: true
      )

    upload: (imageURI) ->
      ft = new FileTransfer
      options = new FileUploadOptions

      options.fileKey = "mentee[avatar]"
      options.fileName = "avatar.jpg"
      options.mimeType = "image/jpeg"
      options.chunkedMode = false
      options.httpMethod = "PUT"
      options.headers = 
        "Accept" : "application/json"
        "Authorization" : "Token token=#{App.currentSession.get('auth_token')}"
        "X-Requested-With": "XMLHttpRequest"

      ft.upload(imageURI, encodeURI(@model.url()),
        (e) =>
          console.log "Avatar uploaded!"
          defer = @model.fetch()
          defer.then =>
            image = @ui.avatarImg
            image.attr('src', @model.get('avatar_mobile_url'))
            @toggleAvatars true
        (e) ->
          console.log "upload failed!"
          navigator.notification.alert 'Photo upload failed. Please try again later' if navigator.notification?
        , options
      )

    toggleAvatars: (hasAvatar) ->
      if hasAvatar
        @ui.avatarImg.removeClass('hidden')
        @ui.defaultUsrIcon.addClass('hidden')
      else
        @ui.avatarImg.addClass('hidden')
        @ui.defaultUsrIcon.removeClass('hidden')
        