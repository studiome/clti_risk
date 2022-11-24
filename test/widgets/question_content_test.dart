import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/questions.dart';
import 'package:clti_risk/widgets/question_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MultipleChoice', (tester) async {
    var pd = PatientData();
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: MultipleQuestionContent(
        question: Questions.sex,
        dataItem: pd.sex,
        values: Sex.values,
        itemHeight: 60.0,
        itemWidth: 160.0,
        tabIndex: Questions.sex.index,
        tabCount: Questions.values.length,
        onChanged: null,
      ),
    )));

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
