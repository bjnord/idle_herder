var topURI = null;

$(document).ready(function () {
  topURI = $('#top-uri').text();
  $('[data-toggle="tooltip"]').tooltip();  // prerequisite for popovers too
  $('[data-toggle="popover"]').popover();
});
