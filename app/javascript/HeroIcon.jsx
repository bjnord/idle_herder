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
    let title = this.props.hero.stars + '★ ' + this.props.hero.name + ' (' + this.props.hero.role + ')';
    return (<div className="hero-image">
      <img src={this.heroImagePath()} height="60" width="60" data-toggle="tooltip" title={title} />
    </div>);
  }
}
