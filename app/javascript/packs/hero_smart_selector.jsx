import React from 'react';
import ReactDOM from 'react-dom';
import HeroSmartSelector from 'HeroSmartSelector.jsx';

document.addEventListener('DOMContentLoaded', () => {
  let topURI = document.getElementById("top-uri").innerHTML;
  ReactDOM.render(
    <HeroSmartSelector topURI={topURI} />,
    document.getElementById('react-hss')
  );
});
