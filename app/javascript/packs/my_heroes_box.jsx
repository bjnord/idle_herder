import React from 'react';
import ReactDOM from 'react-dom';
import MyHeroesBox from 'MyHeroesBox.jsx';

document.addEventListener('DOMContentLoaded', () => {
  let topURI = document.getElementById("top-uri").innerHTML;
  ReactDOM.render(
    <MyHeroesBox topURI={topURI} />,
    document.getElementById('react-mhb')
  );
});
