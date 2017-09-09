export default class SmartTextParser
{
  constructor(text)
  {
    this.filters = {text: text, namePatterns: [], factionToggles: {}};
    this.parse();
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
          this.filters.factionToggles[f] = true;
          return false;
        }
      }
      return true;
    });
  }

  parse()
  {
    let text = this.filters.text.trim();
    if (text) {
      let tokens = text.split(/\s+/);
      // TODO extract "quoted names" to filters.namePatterns
      tokens = this.extractFactions(tokens);
      // TODO extract stars to filters.stars
      // what's left are name words; turn them into regexes:
      // FIXME later this will have to append to the array, not initialize it
      this.filters.namePatterns = tokens.map((token) => this.wordToRegExp(token));
    }
  }
}
