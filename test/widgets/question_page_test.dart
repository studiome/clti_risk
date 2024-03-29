import 'dart:async';

import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:clti_risk/models/questions.dart';
import 'package:clti_risk/widgets/clinical_data_controller.dart';
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
              child: const DefaultTabController(
                  length: 1, child: Scaffold(body: ChoiceTestWidget()))));
    });

    testWidgets('build check', (tester) async {
      await tester.pumpWidget(testApp);
      final subtitle = find.text('Male or Female');
      expect(subtitle, findsOneWidget);
      expect(pd.sex, Sex.female);
      final choice0 = find.text('Male'); // Male
      final choice1 = find.text('Female'); //Female
      expect(choice0, findsOneWidget);
      expect(choice1, findsOneWidget);
      final radio0 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(0));
      final radio1 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(1));
      expect(radio0.value == radio0.groupValue, isFalse);
      expect(radio1.value == radio1.groupValue, isTrue);
    });

    testWidgets('select radio button', (tester) async {
      await tester.pumpWidget(testApp);
      final choice0 = find.text('Male'); // Male
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
      expect(pd.weight, isNull);
      expect(find.text('Body Weight [kg]'), findsNWidgets(2));
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
      expect(pd.weight, isNull);

      final next = find.text('Next');
      await tester.tap(next);
      await tester.pumpAndSettle();
      expect(pd.weight, isNull);
    });

    testWidgets('enter value and submit', (tester) async {
      await tester.pumpWidget(testApp);
      final tab = find.text('TestTab');
      await tester.tap(tab);
      await tester.pumpAndSettle();
      var form = find.byType(TextFormField);
      await tester.enterText(form, '50.0');
      expect(find.text('50.0'), findsOneWidget);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(pd.weight, 50.0);
    });

    testWidgets('enter value and press next', (tester) async {
      await tester.pumpWidget(testApp);
      final tab = find.text('TestTab');
      await tester.tap(tab);
      await tester.pumpAndSettle();
      var form = find.byType(TextFormField);
      final next = find.text('Next');
      await tester.enterText(form, '50.0');
      expect(find.text('50.0'), findsOneWidget);

      await tester.tap(next);
      await tester.pumpAndSettle();
      expect(pd.weight, 50.0);
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
    if (c == null) throw TypeError();
    return MultipleQuestionPage<Sex>(
        subtitle: AppLocalizations.of(context)!.questionSexSubtitle,
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
    if (c == null) throw TypeError();
    return NumberFormQuestionContent(
        title: AppLocalizations.of(context)!.questionWeightTitle,
        subtitle: AppLocalizations.of(context)!.questionWeightSubtitle,
        formController: controller,
        isDecimal: true,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}\.?\d{0,1}')),
        ],
        onSubmitted: (v) {
          try {
            c.patientData.weight = double.parse(v);
          } catch (e) {
            c.patientData.weight = null;
          }
        },
        itemWidth: 240,
        itemHeight: 60,
        tabIndex: 1,
        tabCount: 3);
  }
}
