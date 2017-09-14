import HeroList from 'HeroList.js';
import HeroSieve from 'HeroSieve.js';

import React from 'react';
import HeroBox from 'HeroBox.jsx';
import HeroSmartBar from 'HeroSmartBar.jsx';

export default class HeroFilterBox extends React.Component
{
  constructor(props)
  {
    super(props);
    this.state = {
      heroList: new HeroList(),
      heroSieve: new HeroSieve(),
      smartText: '',
    };
    this.handleSmartTextChange = this.handleSmartTextChange.bind(this);
  }

  handleSmartTextChange(newSmartText, newSmartFilters)
  {
    this.setState(() => ({smartText: newSmartText, heroSieve: new HeroSieve(newSmartFilters)}));
  }

  componentDidMount()
  {
    var heroesPath = topURI + '/heroes.json';
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
        <HeroSmartBar text={this.state.smartText} onTextChange={this.handleSmartTextChange} />
        <HeroBox heroes={this.state.heroList.filteredHeroes(this.state.heroSieve)} items="tiles" />
      </div>
    );
  }
}
