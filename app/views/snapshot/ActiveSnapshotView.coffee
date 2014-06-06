@MM.module "Views.Snapshot", (Snapshot, App, Backbone, Marionette, $, _) ->

  class Snapshot.IntroView extends Marionette.ItemView
    template: 'templates/snapshot/Active'

    triggers:
      'click #self-assess-btn' : 'snapshot:selfassess:clicked'
      'click #explore-btn' : 'snapshot:explore:clicked'
      'click #observe-btn' : 'snapshot:observe:clicked'


