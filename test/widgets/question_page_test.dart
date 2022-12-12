import 'dart:async';

import 'package:clti_risk/models/clinical_data_controller.dart';
import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:clti_risk/models/questions.dart';
import 'package:clti_risk/widgets/question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Multiple Choice Test', () {
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
              child: const Scaffold(body: ChoiceTestWidget())));
    });

    testWidgets('build check', (tester) async {
      await tester.pumpWidget(testApp);
      final subtitle = find.text('Male or Female');
      expect(subtitle, findsOneWidget);
      expect(pd.sex, Sex.female);
      final choice0 = find.text(Sex.values[0].toString()); // Male
      final choice1 = find.text(Sex.values[1].toString()); //Female
      expect(choice0, findsOneWidget);
      expect(choice1, findsOneWidget);
      final radio0 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(0));
      final radio1 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(1));
      expect(radio0.value == radio0.groupValue, isFalse);
      expect(radio1.value == radio1.groupValue, isTrue);
    });

    testWidgets('select radio button', (tester) async {
      await tester.pumpWidget(testApp);
      final choice0 = find.text(Sex.values[0].toString()); // Male
      await tester.tap(choice0);
      await tester.pumpAndSettle();
      expect(pd.sex, Sex.male);
      final radio0 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(0));
      final radio1 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(1));
      expect(radio0.value == radio0.groupValue, isTrue);
      expect(radio1.value == radio1.groupValue, isFalse);
    });
  });

  group('Number Form Test', () {
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
              child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                      appBar: AppBar(
                          bottom: const TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(text: 'dummy1'),
                          Tab(text: 'TestTab'),
                          Tab(text: 'dummy2')
                        ],
                      )),
                      body: TabBarView(children: [
                        const Text('dummy1'),
                        FormTestWidget(),
                        const Text('dummy2')
                      ])))));
    });

    testWidgets('build check', (tester) async {
      await tester.pumpWidget(testApp);
      final tab = find.text('TestTab');
      expect(tab, findsOneWidget);
      await tester.tap(tab);
      await tester.pumpAndSettle();
      expect(pd.height, isNull);
      expect(find.text('Body Height [m]'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      final form = find.byType(TextFormField);
      expect(form, findsOneWidget);
    });

    testWidgets('enter invalid text', (tester) async {
      await tester.pumpWidget(testApp);
      final tab = find.text('TestTab');
      await tester.tap(tab);
      await tester.pumpAndSettle();
      var form = find.byType(TextFormField);
      await tester.enterText(form, 'abcde');
      expect(find.text('abcde'), findsNothing);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(pd.height, isNull);

      final next = find.text('Next');
      await tester.tap(next);
      await tester.pumpAndSettle();
      expect(pd.height, isNull);
    });

    testWidgets('enter value and submit', (tester) async {
      await tester.pumpWidget(testApp);
      final tab = find.text('TestTab');
      await tester.tap(tab);
      await tester.pumpAndSettle();
      var form = find.byType(TextFormField);
      await tester.enterText(form, '1.50');
      expect(find.text('1.50'), findsOneWidget);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(pd.height, 1.50);
    });

    testWidgets('enter value and press next', (tester) async {
      await tester.pumpWidget(testApp);
      final tab = find.text('TestTab');
      await tester.tap(tab);
      await tester.pumpAndSettle();
      var form = find.byType(TextFormField);
      final next = find.text('Next');
      await tester.enterText(form, '1.50');
      expect(find.text('1.50'), findsOneWidget);

      await tester.tap(next);
      await tester.pumpAndSettle();
      expect(pd.height, 1.50);
    });
  });
}

class ChoiceTestWidget extends StatefulWidget {
  const ChoiceTestWidget({super.key});

  @override
  State<ChoiceTestWidget> createState() => _ChoiceTestWidgetState();
}

class _ChoiceTestWidgetState extends State<ChoiceTestWidget> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<Sex>(
        question: Questions.sex,
        values: Sex.values,
        dataItem: c.patientData.sex,
        itemHeight: 60.0,
        itemWidth: 160.0,
        tabIndex: Questions.sex.index,
        tabCount: Questions.values.length,
        onChanged: (v) {
          if (v == null) return;
          setState(() {
            c.patientData.sex = v;
          });
        });
  }
}

class FormTestWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  FormTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return NumberFormQuestionContent(
        question: Questions.height,
        formController: controller,
        isDecimal: true,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d{1}\.?\d{0,2}')),
        ],
        onSubmitted: (v) {
          try {
            c.patientData.height = double.parse(v);
          } catch (e) {
            c.patientData.height = null;
          }
        },
        itemWidth: 240,
        itemHeight: 60,
        tabIndex: 1,
        tabCount: 3);
  }
}
