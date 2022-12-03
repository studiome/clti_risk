import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/patient_data.dart';
import '../models/questions.dart';
import 'question_page.dart';

class RutherfordQuestionPage extends StatefulWidget {
  const RutherfordQuestionPage({super.key});

  @override
  State<RutherfordQuestionPage> createState() => _RutherfordQuestionPageState();
}

class _RutherfordQuestionPageState extends State<RutherfordQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<RutherfordClassification>(
      question: Questions.rutherford,
      values: RutherfordClassification.values,
      dataItem: c.patientData.rutherford,
      itemWidth: 180.0,
      itemHeight: 40.0,
      tabIndex: Questions.rutherford.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.rutherford = v;
        });
      },
    );
  }
}
