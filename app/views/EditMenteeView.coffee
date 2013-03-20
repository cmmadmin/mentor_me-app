MM = require('MentorMe')
template = require('templates/partials/EditMenteeDetailsForm')

module.exports = class EditMenteeView extends Marionette.ItemView
  template: template
  id: 'mentee'

  events:
    'submit form': 'saveMentee'
    'click #edit-mentee-cancel-btn': 'cancelEdit'
    
  onRender: ->
    rivets.bind(@$el, {mentee: @model})
    @$el.find("#phone").mask("(999) 999-9999", {placeholder:" "});

  saveMentee: (e) ->
    # Prevent form submission
    e.preventDefault()

    @$el.find('#edit-mentee-form button.btn-primary').button('saving');
    deferred = @model.save()
    deferred.always =>
      @$el.find('#edit-mentee-form button.btn-primary').button('reset');
    deferred.done =>
      @triggerMethod('mentee:doneEditing')
      # MM.router.navigate('#mentees/' + @model.id, true)

  cancelEdit: (e) ->
    e.preventDefault()
    answer = confirm("Are you sure you want to cancel your changes?")
    if(!answer) 
      return
    @model.restore()
    @triggerMethod('mentee:doneEditing')