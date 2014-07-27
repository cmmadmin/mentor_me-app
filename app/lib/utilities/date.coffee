@MM.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  Date.prototype.today = ->
    return  @getFullYear() + "-" + (if ((@getMonth()+1) < 10) then "0" else "") + (@getMonth()+1) + "-" + (if (@getDate() < 10) then "0" else "") + @getDate()
  
  Date.prototype.timeNow = () ->
    return (if (@getHours() < 10) then "0" else "") + @getHours() + ":" + (if (@getMinutes() < 10) then "0" else "") + @getMinutes() + ":" + (if (@getSeconds() < 10) then "0" else "") + @getSeconds()

  Date.prototype.now = ->
    return @today() + "T" + @timeNow()