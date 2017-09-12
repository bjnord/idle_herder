import React from 'react';
import HeroIcon from 'HeroIcon.jsx';

function heroPath(uri, hero)
{
  return uri + '/heroes/' + hero.id;
}

export default function HeroListItem({ hero, topURI })
{
  return (<li className="hero-item">
    <a className="hero-link" href={heroPath(topURI, hero)}>
      <HeroIcon hero={hero} topURI={topURI} />
      <div className="details">
        <div className="name">{hero.name}</div>
        <div className="role">{hero.stars}★ {hero.role}</div>
      </div>
    </a>
  </li>);
}
