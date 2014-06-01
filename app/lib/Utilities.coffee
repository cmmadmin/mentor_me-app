MM = require('MentorMe')

_sync = Backbone.sync

Backbone.sync = (method, entity, options = {}) ->
  sync = _sync(method, entity, options)
  if !entity._fetch and method is "read"
    entity._fetch = sync
  return sync

MM.commands.setHandler "when:fetched", (entities, callback) ->
  xhrs = _.chain([entities]).flatten().pluck("_fetch").value()

  # if _.isArray(entities)
  #   xhrs.push(entity._fetch) for entity in entities
  # else
  #   xhrs.push(entities._fetch)
  
  $.when(xhrs...).done ->
    callback()