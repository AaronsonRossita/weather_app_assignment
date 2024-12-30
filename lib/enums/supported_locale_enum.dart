import 'dart:ui';

enum SupportedLocale {
  english,
  hebrew,
}

extension LocaleExtension on SupportedLocale {
  Locale get locale {
    switch (this) {
      case SupportedLocale.english:
        return const Locale('en', 'US');
      case SupportedLocale.hebrew:
        return const Locale('he', 'IL');
    }
  }

  String get label {
    switch (this) {
      case SupportedLocale.english:
        return 'English';
      case SupportedLocale.hebrew:
        return 'עברית';
    }
  }
}