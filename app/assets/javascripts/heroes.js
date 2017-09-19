// used by HeroSmartSelector on add-hero forms
function setSelectedHero(hero)
{
  $('#account_hero_hero_id').val(hero.id);
  $('#account-hero-fields :input').prop('disabled', false);
  $('.actions :input[type=submit]').prop('disabled', false);
  for (var i = 1; i <= 10; i++) {
    if ((i < hero.stars) || (i > hero.max_stars)) {
      $('#account_hero_target_stars_' + i).prop('checked', false)
        .parent().hide();
    } else {
      var checkd = (i == hero.max_stars) ? true : false;
      $('#account_hero_target_stars_' + i).prop('checked', checkd)
        .parent().show();
    }
  }
}

// used by HeroSmartSelector on add-hero forms
function unsetSelectedHero()
{
  $('#account_hero_hero_id').val(null);
  $('#account-hero-fields :input').prop('disabled', true);
  $('.actions :input[type=submit]').prop('disabled', true);
  // carefully avoid disturbing the magic hidden checkbox inputs:
  $('#account-hero-fields input[type=text]').val(null);
  $('#account-hero-fields input[type=radio]').prop('checked', false);
  $('#account_hero_is_fodder').prop('checked', false);
}
