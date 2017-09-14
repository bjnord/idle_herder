import React from 'react';
import ReactDOM from 'react-dom';
import HeroFilterBox from 'HeroFilterBox.jsx';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <HeroFilterBox />,
    document.getElementById('react-hfb')
  );
});
