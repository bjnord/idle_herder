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
    this.setInitialFactionToggles();
    this.state = {
      heroList: new HeroList(),
      heroSieve: new HeroSieve({faction: this.initialFactionToggles}, true),
      smartText: '',
      factionToggles: this.initialFactionToggles,
    };
    this.handleFactionsSelected = this.handleFactionsSelected.bind(this);
  }

  setInitialFactionToggles()
  {
    let toggleString = localStorageGetItem('my_heroes_faction_toggles');
    this.initialFactionToggles = {0: false, 1: false, 2: false, 3: false, 4: false, 5: false};
    if (toggleString) {
      for (let i = 0, c = ''; c = toggleString.charAt(i); i++) {
        if (c == '1') {
          this.initialFactionToggles[i] = true;
        }
      }
    }
  }

  storeFactionToggles(toggles)
  {
    let toggleString = '';
    Object.keys(toggles).forEach((key) => {
      toggleString += toggles[key] ? '1' : '0';
    });
    localStorageSetItem('my_heroes_faction_toggles', toggleString);
  }

  handleFactionsSelected(newFactionToggles)
  {
    this.storeFactionToggles(newFactionToggles);
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
