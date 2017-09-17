import React from 'react';
import HeroIcon from 'HeroIcon.jsx';

export default class HeroStamp extends React.Component
{
  constructor(props)
  {
    super(props);
  }

  heroEditPath()
  {
    return topURI + '/account_heroes/' + this.props.hero.account_hero_id + '/edit';
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
      <a className="hero-link" data-modal="true" href={this.heroEditPath()}>
        <HeroIcon hero={this.props.hero} />
        {shardCount}
      </a>
    </li>);
  }
}
