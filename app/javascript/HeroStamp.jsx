import React from 'react';
import HeroIcon from 'HeroIcon.jsx';

function heroPath(uri, hero)
{
  return uri + '/heroes/' + hero.id;
}

export default function HeroStamp({ hero, topURI })
{
  return (<li className="hero-stamp">
    <a className="hero-link" href={heroPath(topURI, hero)}>
      <HeroIcon hero={hero} topURI={topURI} />
    </a>
  </li>);
}
