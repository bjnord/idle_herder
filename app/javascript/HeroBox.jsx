import React from 'react';
import HeroListItem from 'HeroListItem.jsx';

export default function HeroListBox({ heroes, topURI })
{
  return (<ul className="hero-box">
    {heroes.map((hero) => {
      return <HeroListItem key={hero.id} hero={hero} topURI={topURI} />;
    })}
  </ul>);
}
