import HeroList from 'HeroList.js';
import HeroSieve from 'HeroSieve.js';

import React from 'react';
import HeroBox from 'HeroBox.jsx';

export default class MyHeroesBox extends React.Component
{
  constructor(props)
  {
    super(props);
    this.state = {
      heroList: new HeroList(),
      heroSieve: new HeroSieve(null, true),
      smartText: '',
    };
  }

  componentDidMount()
  {
    var heroesPath = topURI + '/account_heroes.json';
    fetch(heroesPath, {headers: {Accept: 'application/json'}, credentials: 'same-origin'})
      .then((res) => res.json())
      .then((json) => {
        this.setState(() => ({heroList: new HeroList(json)}));
      })
      .catch((ex) => {
        console.error('JSON parsing failed: ', ex);
      });
  }

  render()
  {
    return (
      <div>
        <HeroBox heroes={this.state.heroList.filteredHeroes(this.state.heroSieve)} items="stamps" />
      </div>
    );
  }
}
