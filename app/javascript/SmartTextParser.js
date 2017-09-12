export default class SmartTextParser
{
  constructor(text)
  {
    this.filters = {name: [], faction: {}, stars: {}};
    this.parse(text);
  }

  wordToRegExp(word)
  {
    let patt = '\\b' + word.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
    return new RegExp(patt, 'i');
  }

  extractFactions(tokens)
  {
    return tokens.filter((token) => {
      if (token.length == 1) {
        // sadly, "Fortress" and "Forest" overlap significantly
        // so "W" ("Wood") can be used for Forest
        let f = 'SFAWDL'.indexOf(token.toUpperCase());
        if (f >= 0) {
          this.filters.faction[f] = true;
          return false;
        }
      }
      return true;
    });
  }

  extractStars(tokens)
  {
    return tokens.filter((token) => {
      if (token.match(/^\d+$/)) {
        let stars = token;
        let t = stars.indexOf('10');
        while (t >= 0) {
          stars = stars.substring(0, t) + stars.substring(t + 2)
          this.filters.stars['10'] = true;
          t = stars.indexOf('10');
        }
        stars.split('').forEach((star) => {
          this.filters.stars[star] = true;
        });
        return false;
      }
      return true;
    });
  }

  parse(text)
  {
    text = text.trim();
    if (text) {
      let tokens = text.split(/\s+/);
      // TODO extract "quoted names" to filters.name
      tokens = this.extractFactions(tokens);
      tokens = this.extractStars(tokens);
      // what's left are name words; turn them into regexes:
      // FIXME later this will have to append to the array, not initialize it
      this.filters.name = tokens.map((token) => this.wordToRegExp(token));
    }
  }
}
