import React from 'react';

export default function HeroSmartBar({ text, onFilterChange })
{
  function handleChange(event)
  {
    let filters = {text: event.target.value};
    onFilterChange(filters);
  }

  return (
    <div className="hsb-component">
      <input id="hero-smart-bar" placeholder="Search for heroes" aria-label="Search for heroes" value={text} onChange={handleChange} />
    </div>
  );
}
