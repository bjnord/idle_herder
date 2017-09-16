import React from 'react';
import SmartTextParser from 'SmartTextParser.js';

export default class HeroSmartBar extends React.Component
{
  constructor(props)
  {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  componentDidMount()
  {
    $('#smart-bar-help').popover({
      trigger: 'hover click',
      placement: 'left',
      html: true,
      title: "Hero Search Smart Bar",
      content: '<ul>'+
        '<li>Enter the first part of the hero’s name, <i>e.g.</i> “aid” for Aidan</li>'+
        '<li>Enter the first letter of the faction, <i>e.g.</i> “a” for Abyss or “w” for Forest</li>'+
        '<li>Enter the number of stars, <i>e.g.</i> “5610” for 5- 6- and 10-star heroes</li>'+
        '<li>Enter several of these, <i>e.g.</i> “5 gus” for 5-star Gusta, or “s f 56” for all 5- and 6-star Shadow and Fortress heroes</li>'+
        '</ul>',
    });
  }

  helpImagePath()
  {
    return topURI + '/assets/help-icon.png';
  }

  handleFocus(event)
  {
    event.target.select();
  }

  handleChange(event)
  {
    let parser = new SmartTextParser(event.target.value);
    this.props.onTextChange(event.target.value, parser.filters);
  }

  render()
  {
    return (
      <div className="hsb-component form-group">
        <input id="hero-smart-bar" className="form-control" placeholder="Search for heroes" aria-label="Search for heroes" value={this.props.text} autoFocus onFocus={this.handleFocus} onChange={this.handleChange} />
        <img id="smart-bar-help" src={this.helpImagePath()} width="24" height="24" />
      </div>
    );
  }
}
