export default class HeroSieve
{
  constructor(filters, passAllIfEmpty = false)
  {
    if (filters) {
      this.filters = filters;
      //this.debug();
    } else {
      this.filters = {name: [], faction: {}, stars: {}, box_type: []};
    }
    this.passAllIfEmpty = passAllIfEmpty;
    this.wildcards = {};
    this.setWildcards('faction');
  }

  // TODO this should replace areFiltersEmpty()
  setWildcards(key)
  {
    let anyAreTrue = false;
    Object.keys(this.filters[key]).forEach((i) => {
      if (this.filters[key][i]) {
        anyAreTrue = true;
      }
    });
    if (!anyAreTrue && this.passAllIfEmpty) {
      this.wildcards[key] = true;
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
    for (let key in this.filters) {
      if (Array.isArray(this.filters[key])) {
        if (this.filters[key].length > 0) {
          return false;
        }
      } else {
        if (Object.keys(this.filters[key]).length > 0) {
          return false;
        }
      }
    }
    return true;
  }

  filter(heroes)
  {
    if (!this.passAllIfEmpty && this.areFiltersEmpty()) {
      return [];
    }
    return heroes.filter((hero) => {
      for (let key in this.filters) {
        if (Array.isArray(this.filters[key])) {
          if (!HeroSieve.matchesAnyPattern(hero[key], this.filters[key])) {
            return false;
          }
        } else {
          if (key in this.wildcards) {
            return true;
          } else if (!HeroSieve.matchesToggles(hero[key], this.filters[key])) {
            return false;
          }
        }
      }
      return true;
    });
  }

  debug()
  {
    for (let key in this.filters) {
      if (Array.isArray(this.filters[key])) {
        let patterns = this.filters[key].map((regexp) => regexp.toString());
        console.debug(key + '=[' + patterns.join(' | ') + ']');
      } else {
        console.debug(key + '=[' + Object.keys(this.filters[key]).map((i) => { return i+':'+this.filters[key][i]; }).join(',') + ']');
      }
    }
  }
}
