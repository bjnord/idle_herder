import React from 'react';
import HeroStamp from 'HeroStamp.jsx';
import HeroTile from 'HeroTile.jsx';

export default function HeroBox({ heroes, topURI, items })
{
  return (<ul className="hero-box">
    {heroes.map((hero) => {
      let key = hero.account_hero_id ? hero.account_hero_id : hero.id
      if (items && (items == 'stamps')) {
        return <HeroStamp key={key} hero={hero} topURI={topURI} />;
      } else {
        return <HeroTile key={key} hero={hero} topURI={topURI} />;
      }
    })}
  </ul>);
}
