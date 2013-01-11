
(function ($) {
  $.ajaxSetup({
      xhrFields: {
         withCredentials: true
      },
      crossDomain: true,
      beforeSend: function(xhr) {
        xhr.setRequestHeader("Accept", "application/json")
      }
  });
})(jQuery);