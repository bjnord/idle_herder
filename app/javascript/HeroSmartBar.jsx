import React from 'react';
import SmartTextParser from './SmartTextParser';

export default class HeroSmartBar extends React.Component
{
  constructor(props)
  {
    super(props);
    this.handleChange = this.handleChange.bind(this)
  }

  handleFocus(event)
  {
    event.target.select();
  }

  handleChange(event)
  {
    let parser = new SmartTextParser(event.target.value);
    this.props.onFilterChange(parser.filters);
  }

  render()
  {
    return (
      <div className="hsb-component form-group">
        <input id="hero-smart-bar" className="form-control" placeholder="Search for heroes" aria-label="Search for heroes" value={this.props.text} autoFocus onFocus={this.handleFocus} onChange={this.handleChange} />
      </div>
    );
  }
}
