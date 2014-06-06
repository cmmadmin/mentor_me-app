###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM.module "Views.Snapshot", (Snapshot, App, Backbone, Marionette, $, _) ->

  class Snapshot.PreInteractiveQuizView extends Marionette.ItemView
    template: 'templates/snapshot/PreInteractiveQuiz'

    triggers:
      'click #start-snapshot-btn' : 'snapshot:preinteractive:start:clicked'
