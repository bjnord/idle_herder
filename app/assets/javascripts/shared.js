var topURI = null;

$(document).ready(function () {
  topURI = $('#top-uri').text();
  $('[data-toggle="tooltip"]').tooltip();  // prerequisite for popovers too
  $('[data-toggle="popover"]').popover();
});

var localStoragePrefix = 'idle_herder_com_';

function localStorageGetItem(k)
{
  if (typeof(localStorage)) {
    //console.debug('get ' + localStoragePrefix + k);
    return localStorage.getItem(localStoragePrefix + k);
  } else {
    return null;
  }
}

// NB values are stored as strings; booleans won't behave as expected
function localStorageSetItem(k, v)
{
  if (typeof(localStorage)) {
    //console.debug('set ' + localStoragePrefix + k + '=' + v);
    localStorage.setItem(localStoragePrefix + k, v);
  }
}
