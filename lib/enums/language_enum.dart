enum Language { english, hebrew }

extension LanguageExtension on Language {
  String get label {
    switch (this) {
      case Language.hebrew:
        return 'עברית';
      case Language.english:
      return 'English';
    }
  }

  String get hintText {
    switch (this) {
      case Language.hebrew:
        return 'חפש עיר';
      case Language.english:
      return 'Search city';
    }
  }

  String get languageCode {
    switch (this) {
      case Language.hebrew:
        return 'he';
      case Language.english:
      return 'en';
    }
  }
}