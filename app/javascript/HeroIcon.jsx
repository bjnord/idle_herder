import React from 'react';

export default class HeroIcon extends React.Component
{
  constructor(props)
  {
    super(props);
  }

  heroImagePath()
  {
    return this.props.topURI + '/assets/heroes/' + this.props.hero.image_file;
  }

  render()
  {
    return (<div className="hero-image">
      <img src={this.heroImagePath()} height="60" width="60" />
    </div>);
  }
}
