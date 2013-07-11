BackStackRegion = require('lib/ui/BackStackRegion')

module.exports = class AppLayout extends Marionette.Layout
  regions:
    headerRegion: "#pageHeader"
    mainRegion: 
      selector: "#content"
    footerRegion: "#pageFooter"
    modalRegion: "#modal"