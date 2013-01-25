MM = require('Application')
View = require('./supers/View')
template = require('./templates/EditMentee')

module.exports = class EditMenteeView extends View
  template: template
  id: 'mentee'

  events:
    'submit form': 'saveMentee'

  initialize: ->
    
  render: ->
    super
    rivets.bind(@$el, {mentee: @model})
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