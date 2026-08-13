import 'dart:ui';

abstract final class LegalDocumentUrls {
  static const _base = 'https://studiome.github.io/clitical-legal';

  static String _language(Locale locale) =>
      locale.languageCode == 'ja' ? 'ja' : 'en';

  static Uri privacy(Locale locale) =>
      Uri.parse('$_base/privacy/${_language(locale)}/');

  static Uri terms(Locale locale) =>
      Uri.parse('$_base/terms/${_language(locale)}/');

  static Uri support(Locale locale) =>
      Uri.parse('$_base/support/${_language(locale)}/');
}
