import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class CADQuestionPage extends StatefulWidget {
  const CADQuestionPage({super.key});

  @override
  State<CADQuestionPage> createState() => _CADQuestionPageState();
}

class _CADQuestionPageState extends State<CADQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.cad,
      values: YesNo.values,
      dataItem: c.patientData.hasCAD.toYesNo(),
      itemWidth: 180.0,
      itemHeight: 60.0,
      tabIndex: Questions.cad.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasCAD = v.toBool();
        });
      },
    );
  }
}
