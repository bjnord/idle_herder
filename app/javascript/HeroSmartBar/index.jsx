import React from 'react';
import SmartTextParser from './SmartTextParser';

export default function HeroSmartBar({ text, onFilterChange })
{
  function handleChange(event)
  {
    let parser = new SmartTextParser(event.target.value);
    onFilterChange(parser.filters);
  }

  return (
    <div className="hsb-component form-group">
      <input id="hero-smart-bar" className="form-control" placeholder="Search for heroes" aria-label="Search for heroes" value={text} onChange={handleChange} />
    </div>
  );
}
