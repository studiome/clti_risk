import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class SmokingQuestionPage extends StatefulWidget {
  const SmokingQuestionPage({super.key});

  @override
  State<SmokingQuestionPage> createState() => _SmokingQuestionPageState();
}

class _SmokingQuestionPageState extends State<SmokingQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.smoking,
      values: YesNo.values,
      dataItem: c.patientData.isSmoking.toYesNo(),
      itemWidth: 180.0,
      itemHeight: 40.0,
      tabIndex: Questions.smoking.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.isSmoking = v.toBool();
        });
      },
    );
  }
}
