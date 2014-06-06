@MM.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.AppLayout extends Marionette.Layout
    regions:
      headerRegion: "#pageHeader"
      mainRegion:
        selector: "#content"
      footerRegion: "#pageFooter"
      modalRegion: "#modal"