@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.EditMenteeView extends Marionette.ItemView
    template: 'templates/partials/EditMenteeDetailsForm'
    id: 'mentee'

    events:
      'submit form': 'saveMentee'
      'click #edit-mentee-cancel-btn': 'cancelEdit'

    ui:
      saveBtn: '#edit-mentee-save-btn'

    onShow: ->
      @model.store()
      rivets.bind(@$el, {mentee: @model})
      # @$el.find("#phone").mask("(999) 999-9999", {placeholder:" "});

    saveMentee: (e) ->
      # Prevent form submission
      e.preventDefault()

      @ui.saveBtn.button('saving');
      deferred = @model.save()
      deferred.always =>
        @ui.saveBtn.button('reset');
      deferred.done =>
        @triggerMethod('close')
        # MM.router.navigate('#mentees/' + @model.id, true)

    cancelEdit: (e) ->
      e.preventDefault()
      answer = confirm("Are you sure you want to cancel your changes?")
      if(!answer)
        return
      @model.restore()
      @triggerMethod('close')