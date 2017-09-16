// used by HeroSmartSelector on add-hero forms
function setSelectedHeroId(heroId)
{
  let inputTag = document.getElementById("account_hero_hero_id");
  if (inputTag) {
    inputTag.value = heroId;
  } else {
    console.error('setSelectedHeroId(' + heroId + "): can't find input tag for update");
  }
}
