import HeroList from 'HeroList.js';
import HeroSieve from 'HeroSieve.js';

import React from 'react';
import FactionSelector from 'FactionSelector.jsx';
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
      factionToggles: {0: false, 1: false, 2: false, 3: false, 4: false, 5: false},
    };
    this.handleFactionsSelected = this.handleFactionsSelected.bind(this);
  }

  handleFactionsSelected(newFactionToggles)
  {
    this.setState(() => ({heroSieve: new HeroSieve({faction: newFactionToggles}, true), factionToggles: newFactionToggles}));
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
        <FactionSelector toggles={this.state.factionToggles} onFactionsSelected={this.handleFactionsSelected} />
      </div>
    );
  }
}
