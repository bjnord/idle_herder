import React from 'react';
import ReactDOM from 'react-dom';
import MyHeroesBox from 'MyHeroesBox.jsx';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <MyHeroesBox />,
    document.getElementById('react-mhb')
  );
});
