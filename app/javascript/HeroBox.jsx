import React from 'react';
import HeroStamp from 'HeroStamp.jsx';
import HeroTile from 'HeroTile.jsx';

export default class HeroBox extends React.Component
{
  constructor(props)
  {
    super(props);
  }

  render()
  {
    return (<ul className="hero-box">
      {this.props.heroes.map((hero) => {
        let key = hero.account_hero_id ? hero.account_hero_id : hero.id
        if (this.props.items && (this.props.items == 'stamps')) {
          return <HeroStamp key={key} hero={hero} topURI={this.props.topURI} />;
        } else {
          return <HeroTile key={key} hero={hero} topURI={this.props.topURI} />;
        }
      })}
    </ul>);
  }
}
