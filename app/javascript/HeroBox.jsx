import React from 'react';
import HeroSelectableStamp from 'HeroSelectableStamp.jsx';
import HeroStamp from 'HeroStamp.jsx';
import HeroTile from 'HeroTile.jsx';

export default class HeroBox extends React.Component
{
  constructor(props)
  {
    super(props);
    this.handleHeroSelected = this.handleHeroSelected.bind(this);
  }

  handleHeroSelected(heroId)
  {
    this.props.onHeroSelected(heroId);
  }

  render()
  {
    return (<ul className="hero-box">
      {this.props.heroes.map((hero) => {
        let key = hero.account_hero_id ? hero.account_hero_id : hero.id
        if (this.props.items && (this.props.items == 'stamps')) {
          return <HeroStamp key={key} hero={hero} topURI={this.props.topURI} />;
        } else if (this.props.items && (this.props.items == 'selstamps')) {
          let selected = (hero.id == this.props.selectedHeroId) ? true : false;
          return <HeroSelectableStamp key={key} hero={hero} selected={selected} topURI={this.props.topURI} onHeroSelected={this.handleHeroSelected} />;
        } else {
          return <HeroTile key={key} hero={hero} topURI={this.props.topURI} />;
        }
      })}
    </ul>);
  }
}
