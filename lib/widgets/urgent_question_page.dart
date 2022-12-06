import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class UrgentQuestionPage extends StatefulWidget {
  const UrgentQuestionPage({super.key});

  @override
  State<UrgentQuestionPage> createState() => _UrgentQuestionPageState();
}

class _UrgentQuestionPageState extends State<UrgentQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.urgentProcedure,
      values: YesNo.values,
      dataItem: c.patientData.isUrgent.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.urgentProcedure.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.isUrgent = v.toBool();
        });
      },
    );
  }
}
