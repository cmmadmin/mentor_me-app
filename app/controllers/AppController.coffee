MM = require('MentorMe')

Mentee = require('models/Mentee')
Mentees = require('collections/Mentees')
MenteeView = require('views/MenteeView')
EditMenteeView = require('views/EditMenteeView')
JournalView = require('views/JournalView')
JournalEntries = require 'collections/JournalEntries'
SnapshotController = require('controllers/SnapshotController')

module.exports = class AppController extends Marionette.Controller

  home: ->
    Backbone.history.navigate('mentees', trigger: true, replace: true)

  login: ->
    return if MM.loginOpen
    MM.loginOpen = true
    $('#tbModal').append(MM.loginPanel.$el)
    MM.loginPanel.render().delegateEvents()
    $('#tbModal').modal('show')