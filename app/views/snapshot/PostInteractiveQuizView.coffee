###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM.module "Views.Snapshot", (Snapshot, App, Backbone, Marionette, $, _) ->

  class Snapshot.PostInteractiveQuizView extends Marionette.ItemView
    template: 'templates/snapshot/PostInteractiveQuiz'

    triggers:
      'click #start-snapshot-btn' : 'snapshot:postinteractivequiz:confirm:clicked'
