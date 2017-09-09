import React from 'react';

export default function HeroListItem({ hero })
{
  return (<li>
    {hero.stars}★ {hero.name} ({hero.faction})
  </li>);
}
