import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class LesionAIQuestionPage extends StatefulWidget {
  const LesionAIQuestionPage({super.key});

  @override
  State<LesionAIQuestionPage> createState() => _LesionAIQuestionPageState();
}

class _LesionAIQuestionPageState extends State<LesionAIQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.lesionAI,
      values: YesNo.values,
      dataItem: c.patientData.hasAILesion.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.lesionAI.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasAILesion = v.toBool();
        });
      },
    );
  }
}
