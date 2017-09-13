import React from 'react';
import HeroStamp from 'HeroStamp.jsx';
import HeroTile from 'HeroTile.jsx';

export default function HeroBox({ heroes, topURI, items })
{
  return (<ul className="hero-box">
    {heroes.map((hero) => {
      if (items && (items == 'stamps')) {
        return <HeroStamp key={hero.id} hero={hero} topURI={topURI} />;
      } else {
        return <HeroTile key={hero.id} hero={hero} topURI={topURI} />;
      }
    })}
  </ul>);
}
