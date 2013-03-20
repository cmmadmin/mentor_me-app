MM = require('MentorMe')
template = require('templates/EditMentee')

module.exports = class EditMenteeView extends Marionette.ItemView
  template: template
  id: 'mentee'

  events:
    'submit form': 'saveMentee'

  initialize: ->
    super
    
  render: ->
    super
    rivets.bind(@$el, {mentee: @model})
    @$el.find("#phone").mask("(999) 999-9999", {placeholder:" "});
    @

  saveMentee: (e) ->
    # Prevent form submission
    e.preventDefault()

    @$el.find('#edit-mentee-form button.btn-primary').button('saving');
    deferred = @model.save()
    deferred.always =>
      @$el.find('#edit-mentee-form button.btn-primary').button('reset');
    deferred.done =>
      MM.router.navigate('#mentees/' + @model.id, true)