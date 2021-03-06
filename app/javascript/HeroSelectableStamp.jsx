import React from 'react';
import HeroIcon from 'HeroIcon.jsx';

export default class HeroSelectableStamp extends React.Component
{
  constructor(props)
  {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event)
  {
    this.props.onHeroSelected(this.props.hero.id);
  }

  render()
  {
    let selected = this.props.selected ? ' selected' : '';
    return (<li className={'hero-stamp' + selected} onClick={this.handleClick}>
      <HeroIcon hero={this.props.hero} />
    </li>);
  }
}
