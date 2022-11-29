import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class LesionFPQuestionPage extends StatefulWidget {
  const LesionFPQuestionPage({super.key});

  @override
  State<LesionFPQuestionPage> createState() => _LesionFPQuestionPageState();
}

class _LesionFPQuestionPageState extends State<LesionFPQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.lesionFP,
      values: YesNo.values,
      dataItem: c.patientData.hasFPLesion.toYesNo(),
      itemWidth: 180.0,
      itemHeight: 60.0,
      tabIndex: Questions.lesionFP.index,
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
