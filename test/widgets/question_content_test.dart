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
      home: Scaffold(
        body: ClinicalDataController(
            patientData: pd,
            child: ChoiceTestWidget(
              patientData: pd,
            )),
      ),
    ));

    expect(pd.sex, Sex.female);
    final choice0 = find.text(Sex.values[0].toString()); // Male
    final choice1 = find.text(Sex.values[1].toString()); //Female
    expect(choice0, findsOneWidget);
    expect(choice1, findsOneWidget);
    final radio0 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(0));
    final radio1 = tester.widget<Radio<Sex>>(find.byType(Radio<Sex>).at(1));
    expect(radio0.value == radio1.groupValue, isFalse);
    expect(radio1.value == radio1.groupValue, isTrue);
    await tester.tap(choice0);
    await tester.pumpAndSettle();
    expect(pd.sex, Sex.male);
  });
}

class ChoiceTestWidget extends StatelessWidget {
  final PatientData patientData;
  const ChoiceTestWidget({super.key, required this.patientData});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    final d = c.data;
    return Scaffold(
        body: ClinicalDataController(
            patientData: patientData,
            child: ValueListenableBuilder(
              valueListenable: d,
              builder: (context, value, _) {
                return MultipleQuestionContent(
                  question: Questions.sex,
                  values: Sex.values,
                  dataItem: value.sex,
                  itemHeight: 60.0,
                  itemWidth: 160.0,
                  tabIndex: Questions.sex.index,
                  tabCount: Questions.values.length,
                  onChanged: (v) {
                    if (v == null) return;
                    value.sex = v;
                  },
                );
              },
            )));
  }
}
