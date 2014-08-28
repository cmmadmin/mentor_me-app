@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.Mentee extends Model
    urlRoot: Collection.serverUrl('mentees')

    initialize: ->
      super
      @memento = new Backbone.Memento(@);
      _.extend(@, @memento);

    age: ->
      birth_date = @get('birth_date')
      if birth_date
        ageMS = (new Date()) - new Date(birth_date)
        age = new Date()
        age.setTime(ageMS);
        ageYear = age.getFullYear() - 1970; 
      else
        "Unknown"

  Models.on "before:start", ->
    # Supermodel definitions
    Models.Mentee.has().one('active_profile', 
      model: Models.MenteeProfile
      inverse: 'mentee'
    )

    Models.Mentee.has().one('mentor',
      model: App.Entities.User
      inverse: 'mentees'
    )

    Models.Mentee.has().many('journal_entries', 
      collection: App.Entities.JournalEntryCollection
      inverse: 'mentee'
    )
    
  API =
    getMentees: ->
      mentees = new App.Collections.Mentees
      mentees.fetch
        reset: true
      mentees

    getMentee: (id) ->
      App.Models.Mentee.all().getOrFetch(id)

  App.reqres.setHandler "mentees:entities", ->
    API.getMentees()

  App.reqres.setHandler "mentees:entity", (id) ->
    API.getMentee id