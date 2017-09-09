import React from 'react';
import HeroSmartBar from 'HeroSmartBar';

export default class HeroFilter extends React.Component
{
  constructor(props)
  {
    super(props);
    this.state = {smartBarFilters: {text: ''}};
    this.handleFilterChange = this.handleFilterChange.bind(this);
  }

  handleFilterChange(newFilters)
  {
    //console.debug('saw ' + newFilters.text);
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
      <HeroSmartBar text={this.state.smartBarFilters.text} onFilterChange={this.handleFilterChange} />
    );
  }
}
