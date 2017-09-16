import React from 'react';

export default class HeroIcon extends React.Component
{
  constructor(props)
  {
    super(props);
  }

  imagePath(base)
  {
    return topURI + '/assets/' + base;
  }

  render()
  {
    let title, levelLabel, puzzlePiece;
    // FIXME too complicated; break into methods or separate class
    if ('box_type' in this.props.hero) {
      if (this.props.hero.box_type == 'hero') {
        title = this.props.hero.stars + '★ ' + this.props.hero.name + ' (' + this.props.hero.role + ')';
        levelLabel = <div className="level">{this.props.hero.level}</div>;
      } else if (this.props.hero.box_type == 'hero-shards') {
        title = this.props.hero.stars + '★ ' + this.props.hero.name + ' (' + this.props.hero.role + ')';
        puzzlePiece = <img className="puzzle-piece" src={this.imagePath('puzzle-piece-cover.png')} height="18" width="18" />;
        // TODO under-label with # of shards
      } else if (this.props.hero.box_type == 'generic-shards') {
        title = this.props.hero.stars + '★ Generic'  // TODO faction name
        // TODO under-label with # of shards
      } else if (this.props.hero.box_type == 'wish-list') {
        title = this.props.hero.stars + '★ ' + this.props.hero.name + ' (' + this.props.hero.role + ')';
      }
    } else {
      title = this.props.hero.stars + '★ ' + this.props.hero.name + ' (' + this.props.hero.role + ')';
    }
    return (<div className="hero-image">
      <img src={this.imagePath(this.props.hero.image_file)} height="60" width="60" data-toggle="tooltip" title={title} />
      {levelLabel}
      {puzzlePiece}
    </div>);
  }
}
