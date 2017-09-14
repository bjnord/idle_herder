import React from 'react';

export default class HeroIcon extends React.Component
{
  constructor(props)
  {
    super(props);
  }

  heroImagePath()
  {
    return topURI + '/assets/heroes/' + this.props.hero.image_file;
  }

  render()
  {
    let title = this.props.hero.stars + '★ ' + this.props.hero.name + ' (' + this.props.hero.role + ')';
    let levelLabel;
    if (this.props.hero.level) {
      levelLabel = <div className="level">{this.props.hero.level}</div>;
    }
    return (<div className="hero-image">
      <img src={this.heroImagePath()} height="60" width="60" data-toggle="tooltip" title={title} />
      {levelLabel}
    </div>);
  }
}
