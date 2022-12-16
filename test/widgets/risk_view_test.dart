import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:clti_risk/widgets/risk_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PatientData pd;
  group('Risk Viewer Test, [locale:en] ', () {
    setUp(() {
      pd = PatientData();
    });

    testWidgets('normal case,', (tester) async {
      pd
        ..age = 65
        ..height = 1.50
        ..weight = 50.0
        ..alb = 4.0;
      await tester.pumpWidget(TestApp(
        risk: PatientRisk(patientData: pd),
        locale: const Locale('en'),
      ));
      await tester.pumpAndSettle();
      // GNRI
      expect(find.text('101.3'), findsOneWidget);
      // GNRI risk
      expect(find.text('No Risk'), findsOneWidget);
      // 30D Amputation/Death
      expect(find.text('1.3%'), findsOneWidget);
      // 30D MALE

      //drag
      expect(find.text('3.2%'), findsOneWidget);
      await tester.dragUntilVisible(find.text('Predicted 2-year OS'),
          find.byType(ListView), const Offset(0.0, -100.0));
      await tester.pumpAndSettle();

      // 2y OS
      expect(find.text('92%'), findsOneWidget);
      // 2y OS risk
      expect(find.text('Low Risk'), findsOneWidget);
      // 2y AFS
      expect(find.text('88%'), findsOneWidget);
    });
  });
}

class TestApp extends StatelessWidget {
  final PatientRisk risk;
  final Locale locale;
  const TestApp({super.key, required this.risk, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: RiskView(
          risk: risk,
        ));
  }
}
