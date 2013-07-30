module.exports = class Controller extends Marionette.Controller

  constructor: (options = {}) ->
      @region = options.region or App.request "default:region"
      super options
    
  close: (args...) ->
    console.log "Closing controller"
    delete @region
    delete @options
    super args
  
  show: (view) ->
    @listenTo view, "close", @close
    @region.show view