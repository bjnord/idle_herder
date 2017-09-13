// https://jtway.co/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c
$(function() {
  var modal_holder_selector, modal_selector;
  modal_holder_selector = '#modal-holder';
  modal_selector = '.modal';
  $(document).on('click', 'a[data-modal]', function() {
    var location;
    location = $(this).attr('href');
    $.get(location, function(data) {
      return $(modal_holder_selector).html(data).find(modal_selector).modal();
    });
    return false;
  });
  return $(document).on('ajax:success', 'form[data-modal]', function(event, data, status, xhr) {
    var url;
    url = xhr.getResponseHeader('Location');
    if (url) {
      window.location = url;
    } else {
      $('.modal-backdrop').remove();
      $(modal_holder_selector).html(data).find(modal_selector).modal();
    }
    return false;
  });
});
