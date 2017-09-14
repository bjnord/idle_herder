import React from 'react';
import HeroIcon from 'HeroIcon.jsx';

function heroPath(hero)
{
  return topURI + '/heroes/' + hero.id;
}

export default function HeroTile({ hero })
{
  return (<li className="hero-tile">
    <a className="hero-link" href={heroPath(hero)}>
      <HeroIcon hero={hero} />
      <div className="details">
        <div className="name">{hero.name}</div>
        <div className="role">{hero.stars}★ {hero.role}</div>
      </div>
    </a>
  </li>);
}
