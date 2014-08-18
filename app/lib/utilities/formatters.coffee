@MM.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  rivets.formatters.datetimelocalOrNow = (dateString) ->
    if dateString?
      dateString = dateString.slice(0, -1)
    else
      d = new Date
      dateString = d.now()
    dateString