@MM.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  # Backbone Sync Override 
  _sync = Backbone.sync
  Backbone.sync = (method, entity, options = {}) ->
    sync = _sync(method, entity, options)
    if !entity._fetch and method is "read"
      entity._fetch = sync
    return sync

  App.commands.setHandler "when:fetched", (entities, callback) ->
    xhrs = _.chain([entities]).flatten().pluck("_fetch").value()

    # if _.isArray(entities)
    #   xhrs.push(entity._fetch) for entity in entities
    # else
    #   xhrs.push(entities._fetch)
    
    $.when(xhrs...).done ->
      callback()

  $.ajaxSetup
    xhrFields:
      withCredentials: true
    crossDomain: true
    contentType: 'application/json'
    beforeSend: (xhr) ->
      
      xhr.setRequestHeader("Accept", "application/json")
      xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest")
      if App.currentSession
        xhr.setRequestHeader("Authorization", "Token token=#{App.currentSession.get('auth_token')}");