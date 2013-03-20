BackStackRegion = require('lib/ui/BackStackRegion')

module.exports = class AppLayout extends Marionette.Layout
  regions:
    headerRegion: "#pageHeader"
    mainRegion: 
      selector: "#content"
      regionType: BackStackRegion
    footerRegion: "#pageFooter"
    modalRegion: "#modal"