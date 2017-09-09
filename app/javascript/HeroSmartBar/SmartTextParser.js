export default class SmartTextParser
{
  constructor(text)
  {
    this.filters = {text: text};
    this.parse();
  }

  wordToRegExp(word)
  {
    let patt = '\\b' + word.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
    //console.debug('patt=[' + patt + ']');
    return new RegExp(patt, 'i');
  }

  parse()
  {
    let text = this.filters.text.trim();
    if (!text) {
      this.filters.namePatterns = [];
    } else {
      let tokens = text.split(/\s+/);
      // TODO extract "quoted names" to filters.namePatterns
      // TODO extract factions to filters.factions
      // TODO extract stars to filters.stars
      // what's left are name words; turn them into regexes:
      // FIXME later this will have to append to the array, not initialize it
      this.filters.namePatterns = tokens.map((token) => this.wordToRegExp(token));
    }
  }
}
