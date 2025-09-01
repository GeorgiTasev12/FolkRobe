class RegexHelper {
  static final RegExp _wordsOnly = RegExp(r'^[а-яА-Яa-zA-Z0-9\s]+$');
  static final RegExp _lettersAndSymbols = RegExp(r'^[^0-9]+$');
  // ignore: unnecessary_string_escapes
  static final RegExp _noLeadingSpaces = RegExp('^[^\s](.*)?');

  static RegExp get wordsOnly => _wordsOnly;
  static RegExp get noLeadingSpaces => _noLeadingSpaces;
  static RegExp get lettersAndSymbols => _lettersAndSymbols;
}
