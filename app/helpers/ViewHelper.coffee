###
 * Handlebars Template Helpers
 ###
@MM.module "Helpers", (Helpers, App, Backbone, Marionette, Handlebars, $, _) ->
  Handlebars.registerHelper( 'link', ( text, url ) ->

    text = Handlebars.Utils.escapeExpression( text )
    url  = Handlebars.Utils.escapeExpression( url )

    result = '<a href="' + url + '">' + text + '</a>'

    return new Handlebars.SafeString( result )
  )

  Handlebars.registerHelper('dateFormat', (context, block) ->
    if (window.moment)
      f = block.hash.format || "MMM Do, YYYY";
      return moment(new Date(context)).format(f);
    else
      return context;   # moment plugin not available. return data as is. 
  )

  Handlebars.registerHelper('currentTime', (format) ->
    if format
      return moment(new Date()).format(format)
    else
      return new Date()
  )

  Nav = JST['templates/partials/Navigation']
  Handlebars.registerPartial("navigation", Nav)