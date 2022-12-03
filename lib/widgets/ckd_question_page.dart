import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/patient_data.dart';
import '../models/questions.dart';
import 'question_page.dart';

class CKDQuestionPage extends StatefulWidget {
  const CKDQuestionPage({super.key});

  @override
  State<CKDQuestionPage> createState() => _CKDQuestionPageState();
}

class _CKDQuestionPageState extends State<CKDQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<CKD>(
      question: Questions.ckd,
      values: CKD.values,
      dataItem: c.patientData.ckd,
      itemWidth: 180.0,
      itemHeight: 40.0,
      tabIndex: Questions.ckd.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.ckd = v;
        });
      },
    );
  }
}
