
(function ($) {
  $.ajaxSetup({
      xhrFields: {
         withCredentials: true
      },
      crossDomain: true,
      contentType: 'application/json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader("Accept", "application/json");
      }
  });
})(jQuery);