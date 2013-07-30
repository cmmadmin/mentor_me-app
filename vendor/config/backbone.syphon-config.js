Backbone.Syphon.KeyAssignmentValidators.register("textarea", function($el, key, value){
  var isValid = true; 

  if (!value) isValid = false // Disable blank answers for textareas

  return isValid;
});