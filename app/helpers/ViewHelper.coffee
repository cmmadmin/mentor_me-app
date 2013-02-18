###
 * Handlebars Template Helpers
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###


###//--------------------------------------
//+ PUBLIC PROPERTIES / CONSTANTS
//--------------------------------------###

###//--------------------------------------
//+ PUBLIC METHODS / GETTERS / SETTERS
//--------------------------------------###

#
# @return String
#
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