// used by HeroSmartSelector on add-hero forms
function setSelectedHero(hero)
{
  $('#specific_account_hero_hero_id').val(hero.id);
  $('#account-hero-fields :input').prop('disabled', false);
  if (!$('#specific_account_hero_level').val() && !$('#specific_account_hero_shards').val()) {
    $('#specific_account_hero_level').val('1');
  }
  $('.actions :input[type=submit]').prop('disabled', false);
  for (var i = 1; i <= 10; i++) {
    if ((i < hero.stars) || (i > hero.max_stars)) {
      $('#specific_account_hero_target_stars_' + i).prop('checked', false)
        .parent().hide();
    } else {
      var checkd = (i == hero.max_stars) ? true : false;
      $('#specific_account_hero_target_stars_' + i).prop('checked', checkd)
        .parent().show();
    }
  }
}

// used by HeroSmartSelector on add-hero forms
function unsetSelectedHero()
{
  $('#specific_account_hero_hero_id').val(null);
  $('#account-hero-fields :input').prop('disabled', true);
  $('.actions :input[type=submit]').prop('disabled', true);
  // carefully avoid disturbing the magic hidden checkbox inputs:
  $('#account-hero-fields input[type=text]').val(null);
  $('#account-hero-fields input[type=radio]').prop('checked', false);
  $('#specific_account_hero_is_fodder').prop('checked', false);
}
