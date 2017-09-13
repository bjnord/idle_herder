import React from 'react';
import ReactDOM from 'react-dom';
import HeroFilterBox from 'HeroFilterBox.jsx';

document.addEventListener('DOMContentLoaded', () => {
  let topURI = document.getElementById("top-uri").innerHTML;
  ReactDOM.render(
    <HeroFilterBox topURI={topURI} />,
    document.getElementById('react-hfb')
  );
});
