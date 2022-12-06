import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class LocalInfectionQuestionPage extends StatefulWidget {
  const LocalInfectionQuestionPage({super.key});

  @override
  State<LocalInfectionQuestionPage> createState() =>
      _LocalInfectionQuestionPageState();
}

class _LocalInfectionQuestionPageState
    extends State<LocalInfectionQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.localInfection,
      values: YesNo.values,
      dataItem: c.patientData.hasLocalInfection.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.localInfection.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasLocalInfection = v.toBool();
        });
      },
    );
  }
}
