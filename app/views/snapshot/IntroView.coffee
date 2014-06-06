###
 * View Description
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM.module "Views.Snapshot", (Snapshot, App, Backbone, Marionette, $, _) ->

  class Snapshot.IntroView extends Marionette.ItemView
    template: 'templates/snapshot/Intro'

    triggers:
      'click #start-snapshot-btn' : 'snapshot:intro:start:clicked'
