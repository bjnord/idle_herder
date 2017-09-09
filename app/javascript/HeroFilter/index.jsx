import React from 'react';
import HeroSmartBar from 'HeroSmartBar';
import HeroListBox from 'HeroListBox';

function matchesAnyPattern(str, patterns)
{
  if (patterns.length < 1) {
    return true;
  }
  return patterns.some((regexp) => str.match(regexp));
}

function matchesToggles(index, toggles)
{
  if (Object.keys(toggles).length < 1) {
    return true;
  }
  if (index in toggles) {
    return toggles[index];
  }
  return false;
}

function staticHeroList()
{
  return [
    {id: 23, name: 'Bonecarver', faction: 0, stars: 4},
    {id: 24, name: 'Bonecarver', faction: 0, stars: 5},
    {id: 25, name: 'Bonecarver', faction: 0, stars: 6},
    {id: 32, name: 'Dark Priest', faction: 0, stars: 3},
    {id: 82, name: 'Shirley', faction: 0, stars: 3},
    {id: 103, name: 'Fire Fist', faction: 1, stars: 3},
    {id: 161, name: 'Reggie', faction: 1, stars: 3},
    {id: 180, name: 'Storm Hudde', faction: 1, stars: 4},
    {id: 181, name: 'Storm Hudde', faction: 1, stars: 5},
    {id: 184, name: 'Time Mage', faction: 1, stars: 4},
    {id: 185, name: 'Time Mage', faction: 1, stars: 5},
    {id: 217, name: 'Fat Mu', faction: 2, stars: 5},
    {id: 218, name: 'Fat Mu', faction: 2, stars: 6},
    {id: 225, name: 'Gusta', faction: 2, stars: 5},
    {id: 226, name: 'Gusta', faction: 2, stars: 6},
    {id: 343, name: 'Starlight', faction: 3, stars: 5},
    {id: 344, name: 'Starlight', faction: 3, stars: 6},
    {id: 349, name: 'Sybil', faction: 3, stars: 3},
    {id: 350, name: 'Thale', faction: 3, stars: 4},
    {id: 351, name: 'Thale', faction: 3, stars: 5},
    {id: 352, name: 'Thale', faction: 3, stars: 6},
    {id: 363, name: 'Wind Walker', faction: 3, stars: 4},
    {id: 364, name: 'Wind Walker', faction: 3, stars: 5},
    {id: 392, name: 'Logan', faction: 4, stars: 4},
    {id: 393, name: 'Logan', faction: 4, stars: 5},
    {id: 414, name: 'Fegan', faction: 5, stars: 4},
    {id: 415, name: 'Fegan', faction: 5, stars: 5},
  ];
}

export default class HeroFilter extends React.Component
{
  constructor(props)
  {
    super(props);
    this.state = {
      // FIXME when we switch to fetch, this should be []
      heroes: staticHeroList(),
      smartBarFilters: {text: '', namePatterns: [], factionToggles: {}},
    };
    this.handleFilterChange = this.handleFilterChange.bind(this);
  }

  filteredHeroes()
  {
    return this.state.heroes.filter((hero) => {
      if (!matchesAnyPattern(hero.name, this.state.smartBarFilters.namePatterns)) {
        return false;
      }
      if (!matchesToggles(hero.faction, this.state.smartBarFilters.factionToggles)) {
        return false;
      }
      // TODO filter stars
      return true;
    });
  }

  handleFilterChange(newFilters)
  {
    //this.debugFilters(newFilters);
    this.setState(() => ({smartBarFilters: newFilters}));
  }

  /***
  componentDidMount()
  {
    // TODO "fetchJSON()" wrapper method that adds headers: credentials:
    var heroesPath = this.props.path + '/heroes.json';
    fetch(heroesPath, {headers: {Accept: 'application/json'}, credentials: 'same-origin'})
      .then((res) => res.json())
      .then((json) => {
        //console.debug('parsed json', json);
        this.setState({heroes: json});
      })
      .catch((ex) => {
        console.error('JSON parsing failed: ', ex);
      })
  }
  ***/

  render()
  {
    return (
      <div>
        <HeroSmartBar text={this.state.smartBarFilters.text} onFilterChange={this.handleFilterChange} />
        <HeroListBox heroes={this.filteredHeroes()} />
      </div>
    );
  }

  debugFilters(filters)
  {
    //console.debug('text="' + filters.text + '"');
    //let patterns = filters.namePatterns.map((regexp) => regexp.toString());
    //console.debug('namePatterns=[' + patterns.join(' | ') + ']');
    //console.debug('factionToggles=[' + Object.keys(filters.factionToggles).join(',') + ']');
  }
}
