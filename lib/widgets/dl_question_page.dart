import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class DLQuestionPage extends StatefulWidget {
  const DLQuestionPage({super.key});

  @override
  State<DLQuestionPage> createState() => _DLQuestionPageState();
}

class _DLQuestionPageState extends State<DLQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.dyslipidemia,
      values: YesNo.values,
      dataItem: c.patientData.hasDyslipidemia.toYesNo(),
      itemWidth: 180.0,
      itemHeight: 60.0,
      tabIndex: Questions.dyslipidemia.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasDyslipidemia = v.toBool();
        });
      },
    );
  }
}
