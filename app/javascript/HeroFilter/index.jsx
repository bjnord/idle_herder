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

function staticHeroList()
{
  return [
    {id: 23, name: "Bonecarver", faction: "Shadow", stars: 4},
    {id: 24, name: "Bonecarver", faction: "Shadow", stars: 5},
    {id: 25, name: "Bonecarver", faction: "Shadow", stars: 6},
    {id: 217, name: "Fat Mu", faction: "Abyss", stars: 5},
    {id: 218, name: "Fat Mu", faction: "Abyss", stars: 6},
    {id: 225, name: "Gusta", faction: "Abyss", stars: 5},
    {id: 226, name: "Gusta", faction: "Abyss", stars: 6},
    {id: 392, name: "Logan", faction: "Dark", stars: 4},
    {id: 393, name: "Logan", faction: "Dark", stars: 5},
    {id: 414, name: "Fegan", faction: "Light", stars: 4},
    {id: 415, name: "Fegan", faction: "Light", stars: 5},
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
      smartBarFilters: {text: '', namePatterns: []},
    };
    this.handleFilterChange = this.handleFilterChange.bind(this);
  }

  filteredHeroes()
  {
    return this.state.heroes.filter((hero) => {
      if (!matchesAnyPattern(hero.name, this.state.smartBarFilters.namePatterns)) {
        return false;
      }
      // TODO filter factions
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
  }
}
