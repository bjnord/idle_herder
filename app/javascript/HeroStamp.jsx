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
    return topURI + '/heroes/' + this.props.hero.id;
  }

  render()
  {
    let shardCount = null;
    if (this.props.hero.shards > 0) {
      let cls = 'shards-count';
      if (this.props.hero.shards >= this.props.hero.max_shards) {
        cls += ' maxed';
      }
      shardCount = <div className={cls}>{this.props.hero.shards} / {this.props.hero.max_shards}</div>;
    }
    return (<li className="hero-stamp">
      <a className="hero-link" href={this.heroPath()}>
        <HeroIcon hero={this.props.hero} />
        {shardCount}
      </a>
    </li>);
  }
}
