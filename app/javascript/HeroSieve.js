export default class HeroSieve
{
  constructor(filters)
  {
    if (filters) {
      this.filters = filters;
      //this.debug();
    } else {
      this.filters = {namePatterns: [], factionToggles: {}, starToggles: {}};
    }
  }

  static matchesAnyPattern(str, patterns)
  {
    if (patterns.length < 1) {
      return true;
    }
    return patterns.some((regexp) => str.match(regexp));
  }

  static matchesToggles(index, toggles)
  {
    if (Object.keys(toggles).length < 1) {
      return true;
    }
    if (index in toggles) {
      return toggles[index];
    }
    return false;
  }

  areFiltersEmpty()
  {
    if (this.filters.namePatterns.length > 0) {
      return false;
    } else if (Object.keys(this.filters.factionToggles).length > 0) {
      return false;
    } else if (Object.keys(this.filters.starToggles).length > 0) {
      return false;
    } else {
      return true;
    }
  }

  filter(heroes)
  {
    if (this.areFiltersEmpty()) {
      return [];
    }
    return heroes.filter((hero) => {
      if (!HeroSieve.matchesAnyPattern(hero.name, this.filters.namePatterns)) {
        return false;
      }
      if (!HeroSieve.matchesToggles(hero.faction, this.filters.factionToggles)) {
        return false;
      }
      if (!HeroSieve.matchesToggles(hero.stars, this.filters.starToggles)) {
        return false;
      }
      return true;
    });
  }

  debug()
  {
    let patterns = this.filters.namePatterns.map((regexp) => regexp.toString());
    console.debug('namePatterns=[' + patterns.join(' | ') + ']');
    console.debug('factionToggles=[' + Object.keys(this.filters.factionToggles).join(',') + ']');
    console.debug('starToggles=[' + Object.keys(this.filters.starToggles).join(',') + ']');
  }
}
