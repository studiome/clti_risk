import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class CHFQuestionPage extends StatefulWidget {
  const CHFQuestionPage({super.key});

  @override
  State<CHFQuestionPage> createState() => _CHFQuestionPageState();
}

class _CHFQuestionPageState extends State<CHFQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.chf,
      values: YesNo.values,
      dataItem: c.patientData.hasCHF.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.chf.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasCHF = v.toBool();
        });
      },
    );
  }
}
