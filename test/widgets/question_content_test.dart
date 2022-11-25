import 'package:clti_risk/models/clinical_data_controller.dart';
import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/questions.dart';
import 'package:clti_risk/widgets/question_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MultipleChoice', (tester) async {
    final pd = PatientData();
    await tester.pumpWidget(MaterialApp(
        home: ClinicalDataController(
      patientData: pd,
      child: const Scaffold(body: ChoiceTestWidget()),
    )));

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
