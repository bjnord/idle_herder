import React from 'react';

function heroImagePath(uri, hero)
{
  return uri + '/assets/heroes/' + hero.image_file;
}

export default function HeroIcon({ hero, topURI })
{
  return (<div className="hero-image">
    <img src={heroImagePath(topURI, hero)} height="60" width="60" />
  </div>);
}
