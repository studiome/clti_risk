import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class AbnormalWBCQuestionPage extends StatefulWidget {
  const AbnormalWBCQuestionPage({super.key});

  @override
  State<AbnormalWBCQuestionPage> createState() =>
      _AbnormalWBCQuestionPageState();
}

class _AbnormalWBCQuestionPageState extends State<AbnormalWBCQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.abnormalWBC,
      values: YesNo.values,
      dataItem: c.patientData.hasAbnormalWBC.toYesNo(),
      itemWidth: 180.0,
      itemHeight: 40.0,
      tabIndex: Questions.abnormalWBC.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasAbnormalWBC = v.toBool();
        });
      },
    );
  }
}
