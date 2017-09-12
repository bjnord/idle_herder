import React from 'react';
import HeroTile from 'HeroTile.jsx';

export default function HeroListBox({ heroes, topURI })
{
  return (<ul className="hero-box">
    {heroes.map((hero) => {
      return <HeroTile key={hero.id} hero={hero} topURI={topURI} />;
    })}
  </ul>);
}
