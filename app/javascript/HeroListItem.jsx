import React from 'react';

function heroPath(uri, hero)
{
  return uri + '/heroes/' + hero.id;
}

function heroImagePath(uri, hero)
{
  return uri + '/assets/heroes/' + hero.image_file;
}

export default function HeroListItem({ hero, topURI })
{
  // FIXME heroXxx(hero) should be hero.xxx()
  return (<li className="hero-item">
    <a className="hero-link" href={heroPath(topURI, hero)}>
      <div className="image">
        <img src={heroImagePath(topURI, hero)} height="60" width="60" />
      </div>
      <div className="details">
        <div className="name">{hero.name}</div>
        <div className="role">{hero.stars}★ {hero.role}</div>
      </div>
    </a>
  </li>);
}
