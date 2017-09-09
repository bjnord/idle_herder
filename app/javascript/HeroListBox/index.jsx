import React from 'react';
import HeroListItem from 'HeroListItem';

export default function HeroListBox({ heroes })
{
  return (<ul>
    {heroes.map((hero) => {
      return <HeroListItem key={hero.id} hero={hero} />;
    })}
  </ul>);
}
