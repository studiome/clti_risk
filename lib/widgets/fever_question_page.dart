import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class FeverQuestionPage extends StatefulWidget {
  const FeverQuestionPage({super.key});

  @override
  State<FeverQuestionPage> createState() => _FeverQuestionPageState();
}

class _FeverQuestionPageState extends State<FeverQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.fever,
      values: YesNo.values,
      dataItem: c.patientData.hasFever.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.fever.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasFever = v.toBool();
        });
      },
    );
  }
}
