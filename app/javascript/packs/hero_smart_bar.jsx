import React from 'react';
import ReactDOM from 'react-dom';
import HeroFilter from 'HeroFilter';

document.addEventListener('DOMContentLoaded', () => {
  let topURI = document.getElementById("top-uri").innerHTML;
  ReactDOM.render(
    <HeroFilter topURI={topURI} />,
    document.getElementById('react-hsb')
  );
});
