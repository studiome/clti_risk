import 'package:clti_risk/models/clinical_data_controller.dart';
import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/questions.dart';
import 'package:clti_risk/widgets/question_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MultipleChoice', (tester) async {
    final pd = PatientData();
    await tester.pumpWidget(MaterialApp(
        home: ClinicalDataController(
      patientData: pd,
      child: const Scaffold(body: ChoiceTestWidget()),
    )));

    final subtitle = find.text('Male or Female');
    expect(subtitle, findsOneWidget);

    expect(pd.sex, Sex.female);
    final choice0 = find.text(Sex.values[0].toString()); // Male
    final choice1 = find.text(Sex.values[1].toString()); //Female
    expect(choice0, findsOneWidget);
    expect(choice1, findsOneWidget);
    var radio0 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(0));
    var radio1 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(1));
    expect(radio0.value == radio0.groupValue, isFalse);
    expect(radio1.value == radio1.groupValue, isTrue);
    //select [0]
    await tester.tap(choice0);
    await tester.pumpAndSettle();
    expect(pd.sex, Sex.male);
    radio0 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(0));
    radio1 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(1));
    expect(radio0.value == radio0.groupValue, isTrue);
    expect(radio1.value == radio1.groupValue, isFalse);
  });
  testWidgets('Number Form Test', (tester) async {
    final pd = PatientData();
    await tester.pumpWidget(MaterialApp(
        home: ClinicalDataController(
      patientData: pd,
      child: Scaffold(body: FormTestWidget()),
    )));
    expect(pd.height, isNull);
    expect(find.text('Body Height'), findsOneWidget);
    var form = find.byType(TextFormField);
    await tester.enterText(form, '1.50');
    expect(find.text('1.50'), findsOneWidget);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(pd.height, 1.50);
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
    return MultipleQuestionContent<Sex>(
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
      tabIndex: Questions.height.index,
      tabCount: Questions.values.length,
    );
  }
}
