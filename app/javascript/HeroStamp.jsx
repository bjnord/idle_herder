import React from 'react';
import HeroIcon from 'HeroIcon.jsx';

export default class HeroStamp extends React.Component
{
  constructor(props)
  {
    super(props);
  }

  heroPath()
  {
    return this.props.topURI + '/heroes/' + this.props.hero.id;
  }

  render()
  {
    return (<li className="hero-stamp">
      <a className="hero-link" href={this.heroPath()}>
        <HeroIcon hero={this.props.hero} topURI={this.props.topURI} />
      </a>
    </li>);
  }
}
