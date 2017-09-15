import React from 'react';
import FactionToggle from 'FactionToggle.jsx';

export default class FactionSelector extends React.Component
{
  constructor(props)
  {
    super(props);
    this.handleFactionToggled = this.handleFactionToggled.bind(this);
  }

  handleFactionToggled(factionId, value)
  {
    let newToggles = Object.assign({}, this.props.toggles);
    newToggles[factionId] = value;
    this.props.onFactionsSelected(newToggles);
  }

  render()
  {
    return (<ul className="faction-selector">
      {Object.keys(this.props.toggles).map((key) => {
        return <FactionToggle key={key} factionId={key} toggle={this.props.toggles[key]} onToggled={this.handleFactionToggled} />;
      })}
    </ul>);
  }
}
