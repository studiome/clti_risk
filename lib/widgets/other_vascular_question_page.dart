import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class OtherVDQuestionPage extends StatefulWidget {
  const OtherVDQuestionPage({super.key});

  @override
  State<OtherVDQuestionPage> createState() => _OtherVDQuestionPageState();
}

class _OtherVDQuestionPageState extends State<OtherVDQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.others,
      values: YesNo.values,
      dataItem: c.patientData.hasOtherVD.toYesNo(),
      itemWidth: 180.0,
      itemHeight: 60.0,
      tabIndex: Questions.others.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasOtherVD = v.toBool();
        });
      },
    );
  }
}
