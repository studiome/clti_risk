import 'dart:ui';

import 'package:clti_risk/widgets/legal_document_urls.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LegalDocumentUrls', () {
    test('returns Japanese direct URLs for Japanese locale', () {
      const locale = Locale('ja');

      expect(
        LegalDocumentUrls.privacy(locale).toString(),
        'https://studiome.github.io/clitical-legal/privacy/ja/',
      );
      expect(
        LegalDocumentUrls.terms(locale).toString(),
        'https://studiome.github.io/clitical-legal/terms/ja/',
      );
      expect(
        LegalDocumentUrls.support(locale).toString(),
        'https://studiome.github.io/clitical-legal/support/ja/',
      );
    });

    test('returns English direct URLs for non-Japanese locale', () {
      const locale = Locale('en', 'US');

      expect(
        LegalDocumentUrls.privacy(locale).toString(),
        'https://studiome.github.io/clitical-legal/privacy/en/',
      );
      expect(
        LegalDocumentUrls.terms(locale).toString(),
        'https://studiome.github.io/clitical-legal/terms/en/',
      );
      expect(
        LegalDocumentUrls.support(locale).toString(),
        'https://studiome.github.io/clitical-legal/support/en/',
      );
    });
  });
}
