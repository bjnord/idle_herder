import React from 'react';

export default class FactionToggle extends React.Component
{
  constructor(props)
  {
    super(props);
    // FIXME DRY get from Rails
    this.factionNames = {0: 'Shadow', 1: 'Fortress', 2: 'Abyss', 3: 'Forest', 4: 'Dark', 5: 'Light'};
    this.handleToggled = this.handleToggled.bind(this);
  }

  factionImagePath()
  {
    let factionName = this.factionNames[this.props.factionId];
    let off = this.props.toggle ? '' : '-off';
    return topURI + '/assets/' + factionName + off + '.png';
  }

  toggleOnClass()
  {
    return this.props.toggle ? ' toggle-on' : '';
  }

  handleToggled(event)
  {
    let value = !this.props.toggle;
    this.props.onToggled(this.props.factionId, value);
  }

  render()
  {
    return (<li className={'toggle' + this.toggleOnClass()} onClick={this.handleToggled}>
      <img src={this.factionImagePath()} />
    </li>);
  }
}
