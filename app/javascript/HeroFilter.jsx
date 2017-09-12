import HeroList from 'HeroList.js';

import React from 'react';
import HeroBox from 'HeroBox.jsx';
import HeroSmartBar from 'HeroSmartBar.jsx';

export default class HeroFilter extends React.Component
{
  constructor(props)
  {
    super(props);
    this.state = {
      heroList: new HeroList([]),
      smartBarFilters: {text: '', namePatterns: [], factionToggles: {}, starToggles: {}},
    };
    this.handleFilterChange = this.handleFilterChange.bind(this);
  }

  handleFilterChange(newFilters)
  {
    //this.debugFilters(newFilters);
    this.setState(() => ({smartBarFilters: newFilters}));
  }

  componentDidMount()
  {
    var heroesPath = this.props.topURI + '/heroes.json';
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
        <HeroSmartBar text={this.state.smartBarFilters.text} onFilterChange={this.handleFilterChange} />
        <HeroBox heroes={this.state.heroList.filteredHeroes(this.state.smartBarFilters)} topURI={this.props.topURI} />
      </div>
    );
  }

  debugFilters(filters)
  {
    //console.debug('text="' + filters.text + '"');
    //let patterns = filters.namePatterns.map((regexp) => regexp.toString());
    //console.debug('namePatterns=[' + patterns.join(' | ') + ']');
    //console.debug('factionToggles=[' + Object.keys(filters.factionToggles).join(',') + ']');
    //console.debug('starToggles=[' + Object.keys(filters.starToggles).join(',') + ']');
  }
}
