import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class ContraLateralQuestionPage extends StatefulWidget {
  const ContraLateralQuestionPage({super.key});

  @override
  State<ContraLateralQuestionPage> createState() =>
      _ContraLateralQuestionPageState();
}

class _ContraLateralQuestionPageState extends State<ContraLateralQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      question: Questions.contralateral,
      values: YesNo.values,
      dataItem: c.patientData.hasContraLateralLesion.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.contralateral.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasContraLateralLesion = v.toBool();
        });
      },
    );
  }
}
