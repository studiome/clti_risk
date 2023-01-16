import 'dart:async';

import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:clti_risk/widgets/clinical_data_controller.dart';
import 'package:clti_risk/widgets/height_question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PatientData pd;
  late MaterialApp testApp;
  setUp(() {
    pd = PatientData();
    testApp = MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        locale: const Locale('en'),
        home: ClinicalDataController(
            patientData: pd,
            onRiskCalculated: StreamController<PatientRisk>(),
            child: Scaffold(body: HeightTestWidget())));
  });
  group('HeightFormTest', () {
    testWidgets('build check', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();
      expect(pd.height, isNull);
      expect(find.text('Body Height [cm]'), findsNWidgets(2));
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      final form = find.byType(TextFormField);
      expect(form, findsOneWidget);
    });

    testWidgets('enter invalid text', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();
      var form = find.byType(TextFormField);
      await tester.enterText(form, 'abcde');
      expect(find.text('abcde'), findsNothing);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(pd.height, isNull);
    });

    testWidgets('enter value and submit', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();
      var form = find.byType(TextFormField);
      await tester.enterText(form, '150.0');
      expect(find.text('150.0'), findsOneWidget);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(pd.height, 1.50);
    });
  });
}

class HeightTestWidget extends StatelessWidget {
  final TextEditingController heightController = TextEditingController();

  HeightTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return HeightQuestionPage(controller: heightController);
  }
}
