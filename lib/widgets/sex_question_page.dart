import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/patient_data.dart';
import '../models/questions.dart';
import 'question_page.dart';

class SexQuestionPage extends StatefulWidget {
  const SexQuestionPage({super.key});

  @override
  State<SexQuestionPage> createState() => _SexQuestionPageState();
}

class _SexQuestionPageState extends State<SexQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<Sex>(
      question: Questions.sex,
      values: Sex.values,
      dataItem: c.patientData.sex,
      itemWidth: 160.0,
      itemHeight: 60.0,
      tabIndex: Questions.sex.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.sex = v;
        });
      },
    );
  }
}
