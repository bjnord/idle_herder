export default class HeroList
{
  constructor(heroes)
  {
    if (heroes) {
      this.heroes = heroes;
    } else {
      this.heroes = [];
    }
  }

  filteredHeroes(sieve)
  {
    // TODO sorting of this.heroes will go here
    return sieve.filter(this.heroes);
  }

  static testHeroList()
  {
    return [
      {id: 13, name: "Blood Blade", faction: 0, stars: 5},
      {id: 14, name: "Blood Blade", faction: 0, stars: 6},
      {id: 15, name: "Blood Blade", faction: 0, stars: 7},
      {id: 16, name: "Blood Blade", faction: 0, stars: 8},
      {id: 17, name: "Blood Blade", faction: 0, stars: 9},
      {id: 18, name: "Blood Blade", faction: 0, stars: 10},
      {id: 23, name: 'Bonecarver', faction: 0, stars: 4},
      {id: 24, name: 'Bonecarver', faction: 0, stars: 5},
      {id: 25, name: 'Bonecarver', faction: 0, stars: 6},
      {id: 32, name: 'Dark Priest', faction: 0, stars: 3},
      {id: 82, name: 'Shirley', faction: 0, stars: 3},
      {id: 103, name: 'Fire Fist', faction: 1, stars: 3},
      {id: 117, name: "Iceblink", faction: 1, stars: 5},
      {id: 118, name: "Iceblink", faction: 1, stars: 6},
      {id: 119, name: "Iceblink", faction: 1, stars: 7},
      {id: 120, name: "Iceblink", faction: 1, stars: 8},
      {id: 121, name: "Iceblink", faction: 1, stars: 9},
      {id: 122, name: "Iceblink", faction: 1, stars: 10},
      {id: 161, name: 'Reggie', faction: 1, stars: 3},
      {id: 180, name: 'Storm Hudde', faction: 1, stars: 4},
      {id: 181, name: 'Storm Hudde', faction: 1, stars: 5},
      {id: 184, name: 'Time Mage', faction: 1, stars: 4},
      {id: 185, name: 'Time Mage', faction: 1, stars: 5},
      {id: 217, name: 'Fat Mu', faction: 2, stars: 5},
      {id: 218, name: 'Fat Mu', faction: 2, stars: 6},
      {id: 225, name: 'Gusta', faction: 2, stars: 5},
      {id: 226, name: 'Gusta', faction: 2, stars: 6},
      {id: 288, name: "Demon Hunter", faction: 3, stars: 5},
      {id: 289, name: "Demon Hunter", faction: 3, stars: 6},
      {id: 290, name: "Demon Hunter", faction: 3, stars: 7},
      {id: 291, name: "Demon Hunter", faction: 3, stars: 8},
      {id: 292, name: "Demon Hunter", faction: 3, stars: 9},
      {id: 293, name: "Demon Hunter", faction: 3, stars: 10},
      {id: 343, name: 'Starlight', faction: 3, stars: 5},
      {id: 344, name: 'Starlight', faction: 3, stars: 6},
      {id: 349, name: 'Sybil', faction: 3, stars: 3},
      {id: 350, name: 'Thale', faction: 3, stars: 4},
      {id: 351, name: 'Thale', faction: 3, stars: 5},
      {id: 352, name: 'Thale', faction: 3, stars: 6},
      {id: 363, name: 'Wind Walker', faction: 3, stars: 4},
      {id: 364, name: 'Wind Walker', faction: 3, stars: 5},
      {id: 392, name: 'Logan', faction: 4, stars: 4},
      {id: 393, name: 'Logan', faction: 4, stars: 5},
      {id: 414, name: 'Fegan', faction: 5, stars: 4},
      {id: 415, name: 'Fegan', faction: 5, stars: 5},
    ];
  }
}
